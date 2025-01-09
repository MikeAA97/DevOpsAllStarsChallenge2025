#!/bin/bash

# Prompt the user for their S3 Bucket and NBA API token
echo "Enter name of S3 Bucket (One will be created if it does not yet exist):"
read s3_bucket

echo "Enter your NBA API token:"
read nba_api_token

# Generate a random number to help ensure S3-Bucket Name is unique
rand=$(jot -r 1 23456 45678)

# Create the terraform.tfvars file with the provided values
cat <<EOF > terraform.tfvars
datalake_bucket_name = "$s3_bucket-$rand"
nba_api_token        = "$nba_api_token"
EOF

echo "terraform.tfvars file created successfully!"
