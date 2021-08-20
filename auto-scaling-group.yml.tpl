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
  %{~ endif ~}
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
      %{~ if lower(scalingObject) == "launchtemplate" ~}
      LaunchTemplate:
        %{~ if createLt ~}
        LaunchTemplate: "!Ref '${name}LaunchTemplate'"
        Version: !GetAtt '${name}LaunchTemplate.LatestVersionNumber'
        %{~ else ~}
        LaunchTemplateName: "${launchTemplateName}"
        Version: "${launchTemplateVersion}"
        %{~ endif ~}
      %{~ endif ~}
      %{~ if lower(scalingObject) == "mixedinstancespolicy" ~}
      MixedInstancesPolicy:
         InstancesDistribution: 
           OnDemandAllocationStrategy: "${onDemandAllocationStrategy}"
           OnDemandBaseCapacity: "${onDemandBaseCapacity}"
           OnDemandPercentageAboveBaseCapacity: "${onDemandPercentageAboveBaseCapacity}"
           SpotAllocationStrategy: "${spotAllocationStrategy}"
           SpotInstancePools: "${spotInstancePools}"
           SpotMaxPrice: "${spotMaxPrice}"
         LaunchTemplate:
            LaunchTemplateSpecification: 
         %{~ if createLt ~}
               LaunchTemplateId: "!Ref '${name}LaunchTemplate'"
               Version: !GetAtt '${name}LaunchTemplate.LatestVersionNumber'
         %{~ else ~}
               LaunchTemplateName: "${launchTemplateName}"
               Version: "${launchTemplateVersion}"
         %{~ endif ~}
            Overrides: [
            %{~ for override in launchTemplateOverrides ~}
               {
              %{~ if can(override.instanceType) ~}
                  InstanceType: "${override.instanceType}",
              %{~ endif ~}
              %{~ if can(override.launchTemplateSpecification) ~}
                  LaunchTemplateSpecification: 
                %{~ if can(override.launchTemplateSpecification.launchTemplateId) ~}
                    LaunchTemplateId: "${override.launchTemplateSpecification.launchTemplateId}"
                %{~ endif ~}
                %{~ if can(override.launchTemplateSpecification.launchTemplateName) ~}
                    LaunchTemplateName: "${override.launchTemplateSpecification.launchTemplateName}"
                %{~ endif ~}
                %{~ if can(override.launchTemplateSpecification.version) ~}
                    Version: "${override.launchTemplateSpecification.version}"
                %{~ endif ~}
              %{~ endif ~}
              %{~ if can(override.weightedCapacity) ~}
                  WeightedCapacity: "${override.weightedCapacity}",
              %{~ endif ~}
               }
              %{~ if index(launchTemplateOverrides, override) < length(launchTemplateOverrides) - 1 ~}
                ,
              %{~ endif ~}
            %{~ endfor ~}
            ]
      %{~ endif ~}
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
        PauseTime: "${pauseTime}"
        SuspendProcesses:
          - HealthCheck
          - ReplaceUnhealthy
          - AZRebalance
          - AlarmNotification
          - ScheduledActions
        WaitOnResourceSignals: true
    DeletionPolicy: Delete
