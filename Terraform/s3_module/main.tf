# Set the AWS provider and region
provider "aws" {
  region = "ap-south-1"  # Use the region of your choice
}

# Create an S3 bucket
resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-unique-s3-bucket-name-12345"  # Must be globally unique

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Dev"
  }
}

# Set the bucket ACL using a separate resource (as recommended)
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.example_bucket.id
  acl    = "private"  # Grants private access (only the bucket owner has access)
}

# Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.example_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption using AES256
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.example_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
