#!/bin/bash

# Prompt the user for their email address and NBA API token
echo "Enter your email address:"
read email_address

echo "Enter your NBA API token:"
read nba_api_token

# Create the terraform.tfvars file with the provided values
cat <<EOF > terraform.tfvars
email_address = "$email_address"
nba_api_token = "$nba_api_token"
EOF

echo "terraform.tfvars file created successfully!"
