🏷️ 9. Terraform State Management
📁 Terraform State Files (terraform.tfstate)
Purpose: Stores the mapping between real-world resources and your Terraform configuration.

Content: Includes resource metadata, dependencies, outputs, and module information.

Location: By default, saved locally in terraform.tfstate.

🗂️ Remote State vs Local State
Feature	Local State	Remote State
Location	Stored on local disk	Stored in remote backend (e.g., S3)
Collaboration	Not recommended for teams	Enables team collaboration
Locking	Not available	Supported (with supported backends)
Security	Prone to local compromise	Supports encryption and access control

🌐 Backends
Backends determine how state is loaded and how operations like apply are executed.

Examples:

S3 (with DynamoDB): Common for teams. Supports locking via DynamoDB.

Consul: Key-value store that supports locking.

Terraform Cloud / Enterprise: Offers collaboration, versioning, history, etc.

Local: Default backend (local disk).

To configure a backend (example with S3):

h
Copy
Edit
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
🔧 terraform state Commands
Useful for inspecting and modifying state manually:

Command	Description
terraform state list	Lists all resources in state
terraform state show <addr>	Shows details of a resource
terraform state mv	Moves items in state
terraform state rm	Removes items from state
terraform state pull	Retrieves the raw state
terraform state push	Uploads a local state to remote backend

🔒 Locking and State Consistency
Why? Prevents multiple users from applying changes simultaneously.

How?

S3 + DynamoDB provides state locking.

Terraform Cloud/Enterprise has built-in locking.

State consistency ensures that:

No two users overwrite changes.

Infrastructure reflects accurate state.
