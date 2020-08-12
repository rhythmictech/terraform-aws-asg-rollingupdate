Resources:
  %{~ if createLt ~}
  ${name}LaunchTemplate:
    Type: AWS::EC2::LaunchTemplate
    Properties:
      LaunchTemplateName: "${name}"
      LaunchTemplateData:
        ImageId: "${image_id}"
        InstanceType: "${instance_type}"
        SecurityGroupIds: ["${instance_security_groups}"]
        KeyName: "${key_name}"
        UserData:
          Fn::Base64: !Sub |
            #!/bin/bash -x
            yum install -y aws-cfn-bootstrap
            /opt/aws/bin/cfn-init -v \
              --stack $${AWS::StackId} \
              --resource ${name}LaunchTemplate \
              --region $${AWS::Region}
            /opt/aws/bin/cfn-signal \
              --stack $${AWS::StackId} \
              --resource ${name}AutoscalingGroup \
              --region $${AWS::Region}
        TagSpecifications:
          - ResourceType: instance
            Tags: ${tags}
  %{~ endif ~}%
  ${name}AutoscalingGroup:
    Type: AWS::AutoScaling::AutoScalingGroup
    Properties:
      AutoScalingGroupName: "${name}"
      HealthCheckType: "${healthCheck}"
      HealthCheckGracePeriod: 60
      MaxSize: "${maxSize}"
      MaxInstanceLifetime: ${maxLifetime}
      MetricsCollection:
        - Granularity: '1Minute'
      MinSize: "${minSize}"
      %{~ if lower(scalingObject) == "launchtemplate" ~}%
      LaunchTemplate:
        %{~ if createLt ~}
        LaunchTemplate: "!Ref '${name}LaunchTemplate'"
        Version: !GetAtt '${name}LaunchTemplate.LatestVersionNumber'
        %{~ else ~}
        LaunchTemplateName: "${launchTemplateName}"
        Version: "${launchTemplateVersion}"
        %{~ endif ~}
      %{~ endif ~}%
      TargetGroupARNs: ["${targetGroups}"]
      VPCZoneIdentifier: ["${subnets}"]
      Tags: ${asg_tags}
    UpdatePolicy:
    # Ignore differences in group size properties caused by scheduled actions
      AutoScalingScheduledAction:
        IgnoreUnmodifiedGroupSizeProperties: true
      AutoScalingRollingUpdate:
        MaxBatchSize: "${maxBatch}"
        MinInstancesInService: "${minInService}"
        MinSuccessfulInstancesPercent: 80
        PauseTime: PT5M
        SuspendProcesses:
          - HealthCheck
          - ReplaceUnhealthy
          - AZRebalance
          - AlarmNotification
          - ScheduledActions
        WaitOnResourceSignals: true
    DeletionPolicy: Delete
