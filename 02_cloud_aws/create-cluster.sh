aws emr create-cluster --auto-scaling-role EMR_AutoScaling_DefaultRole
--applications Name=JupyterHub Name=TensorFlow Name=Spark
--bootstrap-actions '[{"Path":"s3://oc-p8-data/bootstrap-emr.sh","Name":"Custom action"}]'
--ebs-root-volume-size 10
--ec2-attributes '{"KeyName":"oumeima-oc-p8-ec2","InstanceProfile":"EMR_EC2_DefaultRole","SubnetId":"subnet-04546476ea2ee5783","EmrManagedSlaveSecurityGroup":"sg-0324a04ba10a84d06","EmrManagedMasterSecurityGroup":"sg-06c37f08656243f79"}'
--service-role EMR_DefaultRole --release-label emr-6.3.0 --log-uri 's3n://aws-logs-815565965465-eu-west-1/elasticmapreduce/'
--name 'P8_Fruits'
--instance-groups '[{"InstanceCount":1,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":2}]},"InstanceGroupType":"MASTER","InstanceType":"m5.xlarge","Name":"Master - 1"},{"InstanceCount":2,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":2}]},"InstanceGroupType":"CORE","InstanceType":"m5.xlarge","Name":"Core - 2"}]'
--configurations '[{"Classification":"jupyter-s3-conf","Properties":{"s3.persistance.enabled":"true","s3.persistance.bucket":"oc-p8-data"}}]'
--scale-down-behavior TERMINATE_AT_TASK_COMPLETION
--region eu-west-1