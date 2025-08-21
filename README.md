# Terraform AWS VPC + Subnets + EC2

This repository provisions an AWS environment using Terraform. The infrastructure includes:

- A VPC with CIDR `10.0.0.0/16`
- 3 Public subnets and 3 Private subnets across multiple availability zones
- Internet Gateway for public subnet access
- NAT Gateway for private subnet access
- Route tables for public and private subnets
- Security Group allowing HTTP (port 80)
- An EC2 instance in a public subnet with a public IP

## Prerequisites

- Terraform installed (>= 1.5.0)
- AWS CLI configured with proper credentials
- An existing EC2 key pair for SSH access

## Usage

1. Clone the repository:

```bash
git clone https://github.com/VinayP353/terraform-aws-vpc.git
cd terraform-aws-vpc

terraform init

terraform apply -auto-approve

terraform destroy -auto-approve