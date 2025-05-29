variable "bucket_name" {
  description = "The base name of the S3 bucket (a unique suffix will be added)"
  type        = string
  default     = "my-unique-s3-bucket"
}
