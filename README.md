markdown
# Terraform AWS EC2 with Remote State Backend

Two-part Terraform project: a remote state backend (S3 + DynamoDB) and an EC2 instance built on top of it.

## Structure

.
├── backend-setup/ # Provisions the S3 bucket + DynamoDB table for remote state
│ ├── main.tf
│ ├── outputs.tf
│ └── provider.tf
├── ec2-instance/ # EC2 instance, security group, key pair — uses remote backend
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ ├── provider.tf
│ └── terraform.tfvars.example
└── .gitignore


## Prerequisites

- Terraform >= 1.5.0
- AWS CLI configured (`aws configure`)
- SSH key pair (generated via `ssh-keygen`)

## Usage

### 1. Deploy the backend (once)
```bash
cd backend-setup
terraform init
terraform apply
```

### 2. Deploy the EC2 instance
```bash
cd ../ec2-instance
cp terraform.tfvars.example terraform.tfvars   # fill in your key name/path
terraform init
terraform plan
terraform apply
```

### 3. Connect
```bash
ssh -i ~/.ssh/terraform-ec2-key ec2-user@<instance_public_ip>
```

### 4. Tear down
```bash
terraform destroy          # in ec2-instance/
cd ../backend-setup
terraform destroy          # only if you're done with remote state entirely
```

## Security notes
- SSH (22) is currently open to `0.0.0.0/0` for learning purposes — restrict to your IP (`x.x.x.x/32`) for any real use.
- State is stored remotely in S3 with DynamoDB locking — never commit `.tfstate` or `.tfvars` files.

## Author
Ali Faizan