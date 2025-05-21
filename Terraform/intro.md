✅ Training Goal
Enable students to understand, write, and apply Terraform configurations to provision infrastructure as code (IaC) on AWS (or other cloud providers).

🗓️ Training Agenda (Day-wise or Module-wise)
Day 1: Introduction & Setup
What is Infrastructure as Code (IaC)?

Why Terraform? (vs. CloudFormation, Pulumi, Ansible)

Terraform Architecture & Core Concepts

Installation & Setup (Terraform CLI on EC2)

Setting up AWS credentials (IAM Users/Access Keys)

First Terraform Script (Create an S3 bucket)

Day 2: Terraform Language Basics (HCL)
Providers, Resources, Data Sources

Variables (input, output)

Locals

Terraform Commands: init, plan, apply, destroy

Hands-on: Create EC2 instance with tags

Day 3: Terraform State Management
Purpose of .tfstate

Remote backend setup (S3 + DynamoDB for locking)

terraform state commands

Hands-on: Use remote backend

Day 4: Modules
What are Modules and Why Use Them?

Writing and Using Local Modules

Using Public Modules from the Terraform Registry

Hands-on: Create reusable EC2 module

Day 5: Provisioners and Templating
remote-exec, local-exec

File Provisioner

Template files (templatefile function)

Hands-on: Bootstrap EC2 instance with Apache

Day 6: Workspaces, Environments & Conditionals
Workspaces for managing environments

Conditionals and Loops (count, for_each)

Meta arguments (depends_on, lifecycle)

Hands-on: Dev/Prod setup with workspaces

Day 7: Advanced Terraform
Data Sources (e.g., fetch AMIs)

Resource Dependencies

Dynamic Blocks

Terraform Functions

Hands-on: Create VPC with subnets using loops

Day 8: Real-World Project
Project: Deploy a 3-tier web application

VPC + Subnets

Security Groups

EC2 Instances

Load Balancer

Use modules and remote backend

GitHub integration

Day 9: Terraform with Jenkins (CI/CD)
Automating Terraform with Jenkins pipelines

Use of terraform fmt, validate, plan, apply in pipeline

Storing state securely

Hands-on: Trigger infrastructure changes from Git push

Day 10: Best Practices & Terraform Cloud (Optional)
Folder structure, DRY principle

Secrets management (AWS Secrets Manager, SSM)

Policy as code (Sentinel or Open Policy Agent)

Introduction to Terraform Cloud

