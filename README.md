# CST8918-W25-Final Project
## Group 7 Members
- [Donna Ha (Donna-Smee)](https://github.com/Donna-Smee)
- [Nikki Shakeraneh (NikkiShaker)](https://github.com/NikkiShaker)
- [Qiaoqing Wu (QiaoqingWu-AC)](https://github.com/QiaoqingWu-AC)
- [Yue Gao (Yue0218)](https://github.com/Yue0218)

## Project Overview
This project automates the deployment of a **Remix Weather Application** to Azure using **Infrastructure as Code (IaC)**
via **Terraform** and **CI/CD workflows** powered by **GitHub Actions**. It simulates a real-world environment with multiple teams and environments (dev, test, prod), applying cloud engineering best practices such as **OIDC-based authentication, remote state management**, and **modular Terraform design**.

## Screenshot of the completed GitHub Actions Workflows
(TODO: add screenshot)

## Instructions for Running the Project
### Backend
- Sets up the Azure Blob Storage backend for storing Terraform state.
- Run once locally:
```bash
cd infra/tf-backend
terraform init
terraform plan -out=tf-backend.plan
terraform apply tf-backend.plan
```
### Modules
- Manages:
  - Resource Group
  - Virtual Network + Subnets
  - AKS Clusters (test and prod)
- Uses the remote backend and GitHub OIDC for authentication.
```bash
cd infra/tf-app
terraform init -reconfigure
terraform plan -out=tf-app.plan
terraform apply tf-app.plan
```