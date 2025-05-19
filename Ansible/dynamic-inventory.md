🔍 What is Dynamic Inventory in Ansible?
In Ansible, an inventory is a list of hosts (servers) that you want to manage.

A static inventory is a fixed list of IPs or hostnames in a file (like hosts.ini).

A dynamic inventory automatically queries external sources (like AWS EC2, Azure, etc.) to get a live list of hosts.

Dynamic inventory pulls host data in real-time using a plugin or script.

🧠 Why Use Dynamic Inventory?
Because in dynamic environments (like cloud platforms), your infrastructure changes often:

EC2 instances are started/stopped/scaled dynamically.

IP addresses may change.

New instances come up, old ones go away.

Manually updating a static inventory is error-prone and time-consuming.

✅ Example Use Cases:
Scenario	Static Inventory	Dynamic Inventory
You have 3 fixed servers with known IPs	✅ Easy to manage	Overkill
You're using AWS EC2 and auto-scaling groups	❌ Manually updating IPs is painful	✅ Automatically discovers new instances
Managing multiple environments (dev, staging, prod)	Hard to track manually	✅ Filter by tags/regions
Cloud-native workflows and CI/CD pipelines	Not flexible	✅ Ideal

🛠 How It Works (With AWS Example)
You configure a dynamic inventory plugin (like aws_ec2.yaml).

Ansible queries AWS using your credentials or IAM role.

It fetches a list of currently running EC2 instances.

It groups them by tags, regions, or instance types.

Ansible uses that list during playbook execution.

✅ Benefits of Dynamic Inventory
🔄 Real-time host discovery (no need to maintain a list)

☁️ Cloud-native — works perfectly with AWS, Azure, GCP, etc.

🧠 Smart grouping — based on tags, regions, roles

🔐 Secure — especially when using IAM roles

📈 Scales easily with large infrastructure




**Prerequisites**

Ansible installed on your EC2 instance (you already have this ✅).

IAM user or role with at least ec2:DescribeInstances permission.

AWS CLI installed and configured with credentials.

Python boto3 and botocore libraries installed.

Ansible EC2 dynamic inventory plugin configured.

📦 Step-by-Step Setup
🔹 Step 1: Install AWS CLI (if not already installed)
bash
Copy
Edit
sudo apt update && sudo apt install awscli -y  # Ubuntu
# or
sudo yum install awscli -y                     # Amazon Linux/RHEL/CentOS
🔹 Step 2: Configure AWS CLI
Use IAM credentials (access key and secret key):

bash
Copy
Edit
aws configure
You will be prompted for:

AWS Access Key ID

AWS Secret Access Key

Region (e.g., us-east-1)

Output format (e.g., json)

🔹 Step 3: Install boto3 and botocore (Python packages)
bash
Copy
Edit
pip install boto3 botocore
🔹 Step 4: Enable EC2 dynamic inventory plugin
Ansible has a built-in EC2 dynamic inventory plugin. You'll need a YAML config file like this:

Create a file called aws_ec2.yaml:

yaml
Copy
Edit
plugin: amazon.aws.aws_ec2
regions:
  - us-east-1
keyed_groups:
  - key: tags.Name
    prefix: tag
filters:
  instance-state-name: running
hostnames:
  - private-ip-address
🔄 You can change regions, filters, or hostnames as per your setup.

🔹 Step 5: Install required Ansible collection
Install the AWS collection which includes the dynamic inventory plugin:

bash
Copy
Edit
ansible-galaxy collection install amazon.aws
🔹 Step 6: Test the dynamic inventory
Use this command to test:

bash
Copy
Edit
ansible-inventory -i aws_ec2.yaml --list
You should see a list of your running EC2 instances structured by tags or groups.

🔹 Step 7: Run a playbook using the dynamic inventory
Example:

bash
Copy
Edit
ansible-playbook -i aws_ec2.yaml your_playbook.yaml
🛠️ Tips
Ensure your EC2 instance (where Ansible is installed) has access to the internet or AWS endpoints (NAT or IGW).

You can also use an IAM role for the EC2 instance to avoid storing AWS credentials.
