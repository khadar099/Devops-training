Once your cluster and nodegroup is ready in aws follow the below steps

#1. Configure kubectl to Access Your EKS Cluster
If you haven’t already, install or update the AWS CLI and kubectl:

aws --version
kubectl version --client

# 2. Configure AWS
aws configure

It prompts you for 4 things:

AWS Access Key ID
This is your public key for accessing AWS services.

AWS Secret Access Key
Your private key, used with the access key ID to sign requests securely.

Default region name
This tells the CLI what AWS region to use by default (e.g., us-east-1, us-west-2, etc.).

Default output format
Controls the formatting of command output. Common formats:

json
yaml
text
table

# 3. aws eks update-kubeconfig --region ap-south-1 --name demo-cluster1

Part of Command	What It Means
aws eks	You're using AWS CLI to interact with EKS (Elastic Kubernetes Service).
update-kubeconfig	This tells AWS CLI to generate or update your kubeconfig file.
--region ap-south-1	This is the AWS region where your EKS cluster lives (Mumbai in this case).
--name demo-cluster1	This is the name of your EKS cluster.

📁 What It Actually Does Behind the Scenes:
Looks up your EKS cluster (demo-cluster1) in region ap-south-1.

Gets cluster info like:

Cluster API server endpoint

Certificate authority data

IAM authentication config

Writes/updates your local ~/.kube/config file with a new context for your cluster.

Sets up authentication using AWS IAM Authenticator, so kubectl can use your AWS credentials to access the cluster.



