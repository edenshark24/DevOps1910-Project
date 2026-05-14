# 🚀 Flask Hello World – AWS Cloud Infrastructure (Stage 4)

## 📖 Description
This branch represents Stage 4 of the Flask Hello World DevOps project.
The application is now deployed on AWS using a full production-grade 
infrastructure provisioned via Terraform, with a complete CI/CD pipeline 
running on Jenkins delivering to EKS through ECR.

⚠️ For Kubernetes-only instructions, refer to Stage 3.

## ✅ Requirements

* AWS CLI configured
* Terraform >= 1.0 installed
* kubectl installed
* Helm >= 3.0 installed
* SSH key pair at `~/.ssh/id_rsa.pub`

## 🏗️ Infrastructure Components

| Module | Description |
|--------|-------------|
| **networking** | VPC, public/private subnets, NAT Gateway, VPC Endpoints |
| **security** | Security groups for ALB, EKS, Jenkins, RDS |
| **eks** | Kubernetes cluster with managed node group |
| **jenkins** | CI/CD server on EC2 with all tools pre-installed |
| **rds** | PostgreSQL 15.4 database |
| **ecr** | Private container registry |

## 🐳 Steps

### 1️⃣ Clone and configure
```bash
git checkout stage4-aws
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
vim terraform.tfvars
```

### 2️⃣ Create remote backend
```bash
chmod +x create-backend.sh
./create-backend.sh
```

### 3️⃣ Deploy infrastructure
```bash
terraform init
terraform plan
terraform apply
```

### 4️⃣ Configure kubectl
```bash
aws eks update-kubeconfig \
  --name DevOps1910-cluster \
  --region us-east-1
```

### 5️⃣ Verify cluster
```bash
kubectl get nodes
```

## 🔄 CI/CD Pipeline Stages

1. **Checkout** – Pull latest code
2. **Unit Tests** – pytest
3. **Code Scan** – SonarQube
4. **Build** – Docker image
5. **Image Scan** – Trivy (fails on HIGH/CRITICAL)
6. **Push to ECR** – Private registry
7. **Deploy DEV** – Helm atomic deploy
8. **Integration Tests** – pytest against DEV
9. **Deploy STAGING** – Helm atomic deploy
10. **Manual Approval** – Human gate
11. **Deploy PROD** – Helm atomic deploy (3 replicas)

## 💥 Destroy Infrastructure

⚠️ **Warning:** This will destroy ALL resources including database!

```bash
terraform destroy
```

## 🛠 Key Components Used

* **Terraform** – Modular IaC with remote state in S3 + DynamoDB locking
* **EKS** – Managed Kubernetes across 3 AZs with HPA + Cluster Autoscaler
* **Jenkins** – CI/CD on EC2 with IAM Instance Profile (no hardcoded credentials)
* **RDS** – PostgreSQL outside cluster, 14-day backups, encrypted storage
* **ECR** – Immutable image tags, scan on push enabled
* **VPC Endpoints** – Private connectivity to ECR and CloudWatch

## 📝 Notes

* `terraform.tfvars` is gitignored — use `terraform.tfvars.example` as reference
* NAT Gateway incurs AWS costs — run `terraform destroy` when not in use
* Jenkins is pre-configured with git, docker, kubectl, helm and AWS CLI via user_data
* All sensitive values (passwords, endpoints) marked `sensitive = true` in Terraform
* SSH access to Jenkins restricted to whitelisted IPs only
