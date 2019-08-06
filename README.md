==== Assign an EIP to each of your EC2 Instances in Autoscale Group ====

This configuration is only valid for Autoscaling groups *IN VPC*

1)  Create an EC2 Role in your AWS account using the file policy.txt

2) Request and white-list (if needed) a number of Elastic IP address equal to the max number of server desired in the auto-scaling cluster

3) Tag the resources EIP using ‘instance:not’ which then will change once assigned to an EC2 instance into ‘instance:yes’; to do that you could use the script inside the file tag-em-all.sh

4) Create an Auto-Scaling 'launch configuration' with the option 'assign a public IP address to every instance' and the proper image selected for the Auto-Scaling.

5) Make the Auto-Scaling 'launch configuration' to run the user-data script in User-Data.sh and enforce the use of the role created previously for every new instance.

6) Have one of your server to run the cron tagsYes2Not.sh to identify an re-tag properly all the EIP which are not attached to an instance any more and still having ‘instance:yes’ in the Tags.
