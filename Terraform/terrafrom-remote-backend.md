Step-by-Step: Store Terraform State in S3 with DynamoDB Locking
Step 1: Create S3 Bucket for Terraform State
Login to AWS Console or use AWS CLI.

Create an S3 bucket to hold the Terraform state files.

bash
Copy
Edit
aws s3api create-bucket --bucket my-terraform-state-bucket-unique-name --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1
Replace my-terraform-state-bucket-unique-name with a unique name (S3 bucket names are globally unique).

You can also create it manually via AWS Console.

(Optional) Enable bucket versioning for state history (recommended):

bash
Copy
Edit
aws s3api put-bucket-versioning --bucket my-terraform-state-bucket-unique-name --versioning-configuration Status=Enabled
Step 2: Create DynamoDB Table for State Locking
Create a DynamoDB table to manage state locking:

bash
Copy
Edit
aws dynamodb create-table \
    --table-name terraform-lock-table \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region ap-south-1
Table name here is terraform-lock-table.

This table will store lock entries to prevent concurrent modifications.

Step 3: Add Backend Configuration to Terraform
Create a new file named backend.tf (or add to main.tf but best practice is separate):

hcl
Copy
Edit
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-unique-name"  # Your bucket name
    key            = "terraform/state/terraform.tfstate"      # Path inside bucket
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"                   # DynamoDB table for locking
    encrypt        = true                                      # Encrypt state at rest
  }
}
Step 4: Initialize Terraform with Backend
Run Terraform init to configure the backend:

bash
Copy
Edit
terraform init
Terraform will detect backend configuration and ask to migrate existing state if any.

Confirm by typing yes if prompted.

Step 5: Run Terraform Commands as Usual
Run plan:

bash
Copy
Edit
terraform plan
Apply changes:

bash
Copy
Edit
terraform apply
Terraform will now store its state file in the configured S3 bucket.

DynamoDB will manage the lock to prevent simultaneous changes.

Step 6: Verify Remote State and Locking
Check the S3 bucket to see the terraform.tfstate file.

Check DynamoDB to see lock entries when Terraform is running.

Try running two terraform apply commands simultaneously to confirm locking works (one will wait or error out).

Summary
Step	Description
1	Create S3 bucket for state
2	Create DynamoDB table for locks
3	Add terraform { backend "s3" { ... }} config
4	Run terraform init
5	Use terraform plan and apply
6	Verify state and locking work
