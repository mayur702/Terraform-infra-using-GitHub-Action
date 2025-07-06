# 🛠️ Terraform AWS Infrastructure: VPC & EKS

This project provisions a complete AWS infrastructure using Terraform, including:

- A custom Virtual Private Cloud (VPC) with public and private subnets
- An Amazon Elastic Kubernetes Service (EKS) cluster using the created VPC

The setup follows a modular structure for reusability.
---

## 📁 Project Structure

├── Modules/
│ ├── VPC/ # Reusable VPC module
│ └── EKS/ # Reusable EKS module
├── Envrionment/
│ └── Dev/
│ ├── VPC/ # Root Terraform config for VPC
│ └── EKS/ # Root Terraform config for EKS
└── .github/
└── workflows/
   └── terraform.yml # GitHub Actions CI/CD pipeline



---


---

## 🚀 Getting Started

### 🔧 Prerequisites

- AWS Account
- Terraform v1.6+
- AWS CLI
- IAM User with programmatic access & sufficient permissions
- GitHub repository

---


#### 1. Deploy VPC

```bash
cd Envrionment/Dev/VPC
terraform init
terraform plan
terraform apply
```

2. Deploy EKS (after VPC is ready)

```bash
cd Envrionment/Dev/EKS
terraform init
terraform plan
terraform apply
```





