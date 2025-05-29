# Specify the AWS provider and the region to deploy resources
provider "aws" {
  region = "us-east-1"  # AWS region to deploy the resources (e.g., Virginia). You can change this as needed.
}

# Create an S3 bucket
resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-unique-s3-bucket-name-12345"  # Name of the S3 bucket. Must be globally unique across AWS.
  acl    = "private"  # Access control list - 'private' means only the owner has access.

  tags = {
    Name        = "MyS3Bucket"  # Tag for easier identification in AWS console
    Environment = "Dev"         # Indicates this bucket is used in the Development environment
  }
}

# Enable versioning on the created S3 bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.example_bucket.id  # Reference to the bucket created above

  versioning_configuration {
    status = "Enabled"  # Enables versioning - keeps multiple versions of an object in the same bucket
  }
}

# Enable server-side encryption for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.example_bucket.id  # Reference to the bucket created above

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"  # Use AES256 encryption for objects stored in the bucket
    }
  }
}
