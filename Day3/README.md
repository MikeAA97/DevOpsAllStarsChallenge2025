# Day 3

This project provides a Terraform module to automate the deployment of an AWS Data Lake which consists of the following resources: 

#### AWS Lambda Function
Deploys an AWS Lambda function that queries the SportsData.io API for player information, transform the data, and sends it off to S#.
#### AWS S3 Bucket
Holds all the raw-data, and serves as the output location for Athena queries.
#### AWS Glue Database / Table
Provides the schema, format and location of the NBA dataset.
#### AWS Athena
Custom Workgroup is configured with a template-query. Leverages the AWS Glue Catalog to query the NBA API data hosted in the S3 bucket.


## How to Use This Module

1. **Navigate to the Terraform Directory**  
   Navigate to the `terraform` directory.
<br>
2. **Populate the `terraform.tfvars` file**
    Run the `populate_tfvars.sh` script to generate the `terraform.tfvars` file with your sportsdata.io token.  
    *Note:* You may need to adjust the script's permissions using:  
     `chmod u+x populate_tfvars.sh`
<br>
1. **Configure AWS Credentials**
    Ensure your AWS credentials are properly set up and accessible. You can verify this by checking the `~/.aws/credentials`
<br>
1. **Initialize the Environment**
Run the following command to initialize the terraform environment.
`terraform init`
<br>
1. **Preview the Changes**
Run the following command to preview the resources that will be created:
`terraform plan`
<br>
1. **Apply the Configuration**
If you are satisfied with the plan, apply the changes to create the resources:
`terraform apply --auto-approve`

## Next-Steps
1. **Run the AWS Lambda**
Navigate to the AWS Lambda UI, and ensure a test or real run of the Lambda script happens. This will generate and push data to your S3 Bucket.
<br>
1. **Run an Athena Query**
    1. Navigate to the AWS Athena UI. 
    2. Switch to the nba_analytics workgroup.
    3. Execute the test query
    4. Build out your own custom queries to experiment with how Athena operates.

## Clean-Up

To avoid unintended costs you should destroy the resources if not in use. To do this, simply run
`terraform destroy --auto-approve`