# Day 2

## NBA-API Terraform Module
This project provides a Terraform module to automate the retrieval and delivery of NBA game information using AWS services. The module performs the following:

#### Lambda Function
Deploys an AWS Lambda function that queries the SportsData.io API for up-to-date NBA game information.
#### SNS Topic
Creates an Amazon SNS topic to send the results of the Lambda function to a specified email address.
#### EventBridge Scheduler
Sets up an AWS EventBridge rule to run the Lambda function on a recurring schedule. By default, the schedule is configured to execute every 2 hours, Monday through Friday, between 10:00 AM and 2:00 PM EST.

## How to Use This Module

1. **Navigate to the Terraform Directory**  
   Navigate to the `terraform` directory.
<br>
2. **Populate the `terraform.tfvars` file**  
    Run the `populate_tfvars.sh` script to generate the `terraform.tfvars` file with your email address and NBA API token.  
    *Note:* You may need to adjust the script's permissions using:  
     `chmod u+x populate_tfvars.sh`
<br>
3. **Configure AWS Credentials**
    Ensure your AWS credentials are properly set up and accessible. You can verify this by checking the `~/.aws/credentials`
<br>
4. **Preview the Changes**
Run the following command to preview the resources that will be created:
`terraform plan`
<br>
5. **Apply the Configuration**
If you are satisfied with the plan, apply the changes to create the resources:
`terraform apply --auto-approve`

### Voila
You should receive an email asking to confirm the SNS Subscription. Afterwards you will begin receiving notifications based on the CronJob schedule.

## Clean-Up

To avoid unintended costs you should destroy the resources if not in use. To do this, simply run
`terraform destroy --auto-approve`