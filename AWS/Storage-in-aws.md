In AWS (Amazon Web Services), storage refers to services that allow you to store and manage data in the cloud. These services are highly scalable, durable, and available, and are used to support a wide range of workloads — from static website hosting to databases, backups, media processing, and analytics.

🔹 Why Use AWS Storage?
Elastic scalability (pay-as-you-go)

High durability (e.g., 99.999999999% for S3)

Integrated with other AWS services

Secure with encryption and access control

Global availability via multiple regions and edge locations

🔹 Main AWS Storage Types (With Use Cases)
Category	AWS Service	Use Case

Object Storage	Amazon S3	Backup, static websites, media, big data

Block Storage	Amazon EBS	Boot volumes, databases, file systems

File Storage	Amazon EFS	Shared storage for Linux apps

Archive Storage	Amazon S3 Glacier	Long-term archival & compliance

Hybrid Storage	AWS Storage Gateway	On-premise + AWS cloud integration

Backup	AWS Backup	Centralized backup across services
Transfer	AWS Snowball, AWS DataSync	Large data migrations


✅ 1. Amazon S3 (Simple Storage Service) — Object Storage
➤ Description:
Stores data as objects (files) in buckets.

Each object has metadata and a unique key.

Highly durable (11 9’s).

Scales automatically.

➤ Storage Classes:
Class	Use Case
S3 Standard	               -   Frequently accessed data
S3 Intelligent-Tiering	   -   Unpredictable access patterns
S3 Standard-IA	           -   Infrequent access
S3 One Zone-IA	           -   Infrequent access, 1 zone only
S3 Glacier	               -   Archival (minutes to hours)
S3 Glacier                 -   Deep Archive	Long-term archive (hours)

➤ Example:
Store images for a website:

bash
Copy
Edit
aws s3 mb s3://my-image-bucket
aws s3 cp image.jpg s3://my-image-bucket/
✅ 2. Amazon EBS (Elastic Block Store) — Block Storage
➤ Description:
Block-level storage for EC2 instances.

Persist even after EC2 reboots.

SSD & HDD options.

➤ Volume Types:
Type	Use Case
gp3 (General Purpose SSD)	Most workloads
io2/io1 (Provisioned IOPS SSD)	High-performance DBs
st1 (Throughput Optimized HDD)	Big data, streaming
sc1 (Cold HDD)	Infrequently accessed workloads

➤ Example:
Attach EBS to an EC2:

bash
Copy
Edit
# Launch EC2 and add EBS in console
lsblk       # Check device
sudo mkfs.ext4 /dev/xvdf
sudo mount /dev/xvdf /mnt/data
✅ 3. Amazon EFS (Elastic File System) — File Storage
➤ Description:
Fully managed NFS file system.

Shared between multiple EC2 instances.

Grows/shrinks automatically.

➤ Use Case:
Web applications, home directories, CMS like WordPress.

➤ Example:
bash
Copy
Edit
sudo yum install -y amazon-efs-utils
sudo mount -t efs fs-123456:/ /mnt/efs
✅ 4. Amazon S3 Glacier & Glacier Deep Archive — Archival
➤ Description:
Designed for data archiving and long-term backup.

Retrieval can take minutes to hours.

➤ Use Case:
Compliance data, logs, long-term backups.

➤ Example:
Move data to Glacier:

bash
Copy
Edit
aws s3 cp myfile.txt s3://my-bucket/ --storage-class GLACIER
✅ 5. AWS Storage Gateway — Hybrid Storage
➤ Description:
Connect on-premise environments to AWS storage.

File, Volume, or Tape gateway.

➤ Use Case:
Backup on-prem data to cloud.

Use S3 as local storage.

✅ 6. AWS Backup — Centralized Backup
➤ Description:
Centralized backup service for AWS services.

Supports EBS, RDS, DynamoDB, EFS, etc.

➤ Use Case:
Compliance, disaster recovery.

✅ 7. AWS Snowball / Snowmobile — Data Transfer Appliances
➤ Description:
Physical devices used to transfer data at petabyte scale.

➤ Use Case:
Migrate large datasets when internet is slow or expensive.

🔹 When to Use What (Scenarios)
Use Case	Recommended Storage
Static website, images, backups	Amazon S3
Databases, boot volumes	Amazon EBS
Multiple EC2 sharing files	Amazon EFS
Long-term compliance storage	Amazon S3 Glacier
Hybrid setup (on-prem + cloud)	AWS Storage Gateway
Centralized backups	AWS Backup
Mass data transfer to AWS	Snowball/Snowmobile

🛠️ Step-by-Step Example: Upload Image to S3
1. Create an S3 Bucket
bash
Copy
Edit
aws s3 mb s3://khadar-bucket-demo
2. Upload a File
bash
Copy
Edit
aws s3 cp cat.jpg s3://khadar-bucket-demo/
3. Make it Public (Not Recommended for sensitive data)
bash
Copy
Edit
aws s3api put-object-acl --bucket khadar-bucket-demo --key cat.jpg --acl public-read
4. Access via URL
bash
Copy
Edit
https://khadar-bucket-demo.s3.amazonaws.com/cat.jpg
🔐 Security Best Practices
🔒 Encrypt using SSE-S3 or SSE-KMS.

📜 Use IAM roles/policies to limit access.

❌ Block public access by default.

🕵️ Enable S3 Access Logs.

📁 Use Object Lock for WORM protection.

🤖 Use AWS Macie for PII discovery.

