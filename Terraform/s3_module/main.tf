# Set the AWS provider and region
provider "aws" {
  region = "ap-south-1"
}

# Generate a random ID suffix to ensure bucket name uniqueness
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Create an S3 bucket with a unique name
resource "aws_s3_bucket" "example_bucket" {
  bucket = "${var.bucket_name}-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Dev"
  }
}

# Set the bucket ACL
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.example_bucket.id
  acl    = "private"
}

# Enable versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.example_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.example_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
