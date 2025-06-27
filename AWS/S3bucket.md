What is an S3 Bucket?

An S3 Bucket is like a folder in the cloud:

It stores objects (files like images, videos, documents, backups, etc.)

Each bucket has a globally unique name

Buckets reside in regions (e.g., us-east-1, ap-south-1)


Why Do We Use S3? or what is the use?

Store and serve static files (e.g., websites, images)

Backup and restore critical data

Log storage

Data lake for big data analytics

Hosting static websites

Integration with services like Lambda, CloudFront, Athena




Public vs Private Bucket
🔒 By default, all buckets and objects are private.
✅ To make a bucket public:
Step 1: Unblock public access
Go to S3 Console > Bucket > Permissions > Block Public Access

Uncheck "Block all public access"

Step 2: Add a bucket policy:
json
Copy
Edit
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "PublicReadGetObject",
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::your-bucket-name/*"
  }]
}
🔥 Use with caution: this makes all files publicly accessible.

🔐 How to Secure Your S3 Bucket?
✅ Keep "Block all public access" enabled

🔑 Use Bucket Policies to control access

📃 Use IAM roles/policies to limit who can read/write

🔒 Enable encryption (SSE-S3 or SSE-KMS)

🔍 Enable S3 Access Logs to track usage

📜 Use Object Lock for WORM (Write Once Read Many)

🔐 Integrate with AWS Macie for data protection

📦 How Many Buckets Can You Create?
Default limit: 100 buckets per AWS account

You can request a limit increase via AWS Support

There is no limit on the number of objects per bucket

⚙️ AWS CLI Commands for S3
📁 List Buckets
bash
Copy
Edit
aws s3 ls
📦 Create Bucket
bash
Copy
Edit
aws s3 mb s3://my-bucket-name --region ap-south-1
🧾 Upload File
bash
Copy
Edit
aws s3 cp file.txt s3://my-bucket-name/
⬇️ Download File
bash
Copy
Edit
aws s3 cp s3://my-bucket-name/file.txt .
📂 Sync Folder to Bucket

aws s3 sync ./local-folder s3://my-bucket-name
❌ Delete Bucket

aws s3 rb s3://my-bucket-name --force
🔍 List Objects in a Bucket
bash
Copy
Edit
aws s3 ls s3://my-bucket-name/
📌 Example: Make Object Public (Single File)
bash
Copy
Edit
aws s3api put-object-acl --bucket my-bucket-name --key file.txt --acl public-read




S3 Bucket Size Limits
Property	Limit
Max number of buckets/account	  -   100 (soft limit, can request increase)
Max objects per bucket	        -   Unlimited
Max size per object             -  	5 TB
Total bucket size	              -   Unlimited (only limited by how much you want to pay)
