# 🚀 End-to-End DevSecOps Kubernetes Project

> **Deploy a Tetris Game on AWS EKS using Terraform, Jenkins, and ArgoCD with full DevSecOps practices**

![DevSecOps](https://img.shields.io/badge/DevSecOps-Pipeline-blue?style=for-the-badge)
![AWS](https://img.shields.io/badge/AWS-EKS-orange?style=for-the-badge&logo=amazon-aws)
![Kubernetes](https://img.shields.io/badge/Kubernetes-v1.27-326CE5?style=for-the-badge&logo=kubernetes)
![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC?style=for-the-badge&logo=terraform)
![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?style=for-the-badge&logo=jenkins)
![ArgoCD](https://img.shields.io/badge/ArgoCD-GitOps-EF7B4D?style=for-the-badge&logo=argo)

---

## 📋 Table of Contents

- [Project Overview](#-project-overview)
- [Architecture](#-architecture)
- [Prerequisites](#-prerequisites)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Step-by-Step Setup](#-step-by-step-setup)
  - [Step 1: IAM User & Access Keys](#step-1-iam-user--access-keys)
  - [Step 2: Install Terraform & AWS CLI](#step-2-install-terraform--aws-cli)
  - [Step 3: Deploy Jenkins Server via Terraform](#step-3-deploy-jenkins-server-via-terraform)
  - [Step 4: Configure Jenkins](#step-4-configure-jenkins)
  - [Step 5: Deploy EKS Cluster via Jenkins](#step-5-deploy-eks-cluster-via-jenkins)
  - [Step 6: Install & Configure ArgoCD](#step-6-install--configure-argocd)
  - [Step 7: Deploy Tetris App v1](#step-7-deploy-tetris-app-v1)
  - [Step 8: Deploy Tetris App v2](#step-8-deploy-tetris-app-v2)
  - [Step 9: Cleanup](#step-9-cleanup)
- [Security Tools](#-security-tools)
- [Contributing](#-contributing)
- [Author](#-author)

---

## 🌟 Project Overview

This project demonstrates a complete **End-to-End DevSecOps pipeline** on AWS. It covers infrastructure provisioning, CI/CD automation, container security scanning, code quality analysis, and GitOps-based continuous deployment — all centered around deploying a Tetris game application on an Amazon EKS cluster.

Key highlights:
- **Infrastructure as Code** with Terraform for both Jenkins Server and EKS Cluster
- **CI/CD Pipeline** with Jenkins for building, testing, and deploying
- **Security Scanning** using Trivy (container), OWASP Dependency-Check (dependencies), and SonarQube (code quality)
- **GitOps Deployment** with ArgoCD for automated Kubernetes deployments
- **Versioned Deployments** showcasing rolling updates from v1 to v2

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        Developer Workflow                        │
│                                                                 │
│   Local Machine ──► GitHub Repo ──► Jenkins Pipeline           │
│   (Terraform/CLI)    (Source Code)   (CI/CD + Security)        │
└────────────────────────────┬────────────────────────────────────┘
                             │
              ┌──────────────▼──────────────┐
              │        Jenkins Server        │
              │  (EC2 Instance on AWS)       │
              │                             │
              │  ┌─────────┐ ┌──────────┐  │
              │  │SonarQube│ │  Trivy   │  │
              │  └─────────┘ └──────────┘  │
              │  ┌──────────────────────┐  │
              │  │  OWASP Dep-Check     │  │
              │  └──────────────────────┘  │
              └──────────────┬─────────────┘
                             │
              ┌──────────────▼──────────────┐
              │       Docker Hub            │
              │   (Container Registry)      │
              └──────────────┬─────────────┘
                             │
              ┌──────────────▼──────────────┐
              │    ArgoCD (GitOps)          │
              │    Watches GitHub Repo      │
              └──────────────┬─────────────┘
                             │
              ┌──────────────▼──────────────┐
              │      AWS EKS Cluster        │
              │   ┌────────────────────┐   │
              │   │  Tetris Namespace  │   │
              │   │  (Game App v1/v2)  │   │
              │   └────────────────────┘   │
              │   ┌────────────────────┐   │
              │   │  ArgoCD Namespace  │   │
              │   └────────────────────┘   │
              └─────────────────────────────┘
```

---

## ✅ Prerequisites

Before starting, ensure you have the following:

| Requirement | Details |
|---|---|
| **AWS Account** | With permissions to create IAM users, EC2, EKS, S3, DynamoDB |
| **Terraform** | v1.0+ installed on local machine |
| **AWS CLI** | Configured with access keys |
| **Git** | Basic knowledge of Git commands |
| **Docker Hub Account** | For pushing container images |
| **GitHub Account** | With a Personal Access Token generated |
| **Basic Knowledge** | Kubernetes, Jenkins, Docker, CI/CD concepts |

---

## 🛠️ Tech Stack

| Category | Tools |
|---|---|
| **Cloud Provider** | AWS (EC2, EKS, IAM, S3, DynamoDB, Load Balancer) |
| **IaC** | Terraform |
| **CI/CD** | Jenkins |
| **GitOps** | ArgoCD |
| **Containerization** | Docker |
| **Container Orchestration** | Kubernetes (EKS) |
| **Code Quality** | SonarQube |
| **Container Security** | Trivy |
| **Dependency Security** | OWASP Dependency-Check |
| **Runtime** | Node.js |
| **Container Registry** | Docker Hub |

---

## 📁 Project Structure

```
End-to-End-Kubernetes-DevSecOps-Tetris-Project/
│
├── Jenkins-Server-TF/          # Terraform code to provision Jenkins EC2
│   ├── backend.tf
│   ├── main.tf
│   ├── variables.tf
│   └── variables.tfvars
│
├── EKS-TF/                     # Terraform code to provision EKS Cluster
│   ├── backend.tf
│   ├── main.tf
│   ├── variables.tf
│   └── variables.tfvars
│
├── Jenkins-Pipeline-Code/      # Jenkinsfile pipeline definitions
│   ├── Jenkinsfile             # Pipeline for Tetris v1
│   ├── Jenkinsfile-TetrisV2    # Pipeline for Tetris v2
│   └── Jenkinsfile-EKS-Terraform  # Pipeline to deploy/destroy EKS
│
├── K8s/                        # Kubernetes manifest files
│   ├── deployment.yaml
│   └── service.yaml
│
├── tetris-v1/                  # Tetris Version 1 source code
│   └── Dockerfile
│
└── tetris-v2/                  # Tetris Version 2 source code
    └── Dockerfile
```

---

## 📖 Step-by-Step Setup

### Step 1: IAM User & Access Keys

1. Navigate to **AWS IAM** → **Users** → **Create User**
2. Attach **AdministratorAccess** policy *(use least-privilege in production)*
3. Go to **Security Credentials** → **Create Access Key**
4. Select **Command Line Interface (CLI)** and download the CSV

> ⚠️ **Security Note:** AdministratorAccess is used here for simplicity. In production environments, always follow the principle of least privilege.

---

### Step 2: Install Terraform & AWS CLI

**Install Terraform:**
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y
```

**Install AWS CLI:**
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install
```

**Configure AWS CLI:**
```bash
aws configure
# Enter: AWS Access Key ID, Secret Access Key, Region (e.g. us-east-1), Output format (json)
```

**Set Terraform environment variables** in `/etc/environment`:
```
AWS_ACCESS_KEY_ID="your-access-key"
AWS_SECRET_ACCESS_KEY="your-secret-key"
```

---

### Step 3: Deploy Jenkins Server via Terraform

```bash
# Clone the repository
git clone https://github.com/AmanPathak-DevOps/End-to-End-Kubernetes-DevSecOps-Tetris-Project.git
cd End-to-End-Kubernetes-DevSecOps-Tetris-Project/Jenkins-Server-TF

# Update backend.tf with your S3 bucket name and DynamoDB table
# Update variables.tfvars with your existing PEM key name

# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Preview infrastructure changes
terraform plan -var-file=variables.tfvars

# Apply and create infrastructure
terraform apply -var-file=variables.tfvars --auto-approve
```

**Verify installed tools on the Jenkins server:**
```bash
jenkins --version
docker --version && docker ps
terraform --version
kubectl version
aws --version
trivy --version
```

Access Jenkins at: `http://<JENKINS_PUBLIC_IP>:8080`

Get the initial admin password:
```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

---

### Step 4: Configure Jenkins

1. Install suggested plugins and complete initial setup
2. Install additional plugins via **Manage Jenkins → Plugins → Available Plugins**:
   - `AWS Credentials`
   - `Pipeline: AWS Steps`
   - `Docker`, `Docker Commons`, `Docker Pipeline`, `Docker API`, `docker-build-step`
   - `Eclipse Temurin installer`
   - `NodeJS`
   - `OWASP Dependency-Check`
   - `SonarQube Scanner`

3. **Add AWS Credentials:** Manage Jenkins → Credentials → Global → Add Credentials → Kind: *AWS Credentials*

4. **Configure Tools** (Manage Jenkins → Tools):
   - JDK (jdk17)
   - NodeJS (node16)
   - OWASP Dependency-Check
   - Docker
   - SonarQube Scanner

5. **Configure SonarQube:**
   - Access SonarQube at `http://<JENKINS_PUBLIC_IP>:9000` (default: admin/admin)
   - Generate a token: Administration → Security → Users → Update Tokens
   - Add webhook: Administration → Configuration → Webhooks → `http://<JENKINS_IP>:8080/sonarqube-webhook/`
   - Add token to Jenkins credentials as *Secret Text* with ID `sonar-token`
   - Configure in Manage Jenkins → System → SonarQube Installations

6. **Add Docker Hub credentials:** ID `docker`, with your Docker Hub username and password

7. **Add GitHub credentials:** Kind: *Secret Text*, paste your GitHub Personal Access Token

---

### Step 5: Deploy EKS Cluster via Jenkins

1. Create a new Pipeline job: `EKS-Terraform-Deploy`
2. Copy pipeline code from [`Jenkinsfile-EKS-Terraform`](Jenkins-Pipeline-Code/Jenkinsfile-EKS-Terraform)
3. Update `EKS-TF/backend.tf` with your S3 bucket and DynamoDB table names
4. Click **Build** and monitor the pipeline

**After successful deployment, configure kubectl on the Jenkins server:**
```bash
aws eks update-kubeconfig --region us-east-1 --name Tetris-EKS-Cluster

# Validate cluster connection
kubectl get nodes
```

---

### Step 6: Install & Configure ArgoCD

```bash
# Create application namespace
kubectl create namespace tetris

# Create ArgoCD namespace and install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.7/manifests/install.yaml

# Verify ArgoCD pods are running
kubectl get pods -n argocd

# Expose ArgoCD via LoadBalancer
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# Install jq for JSON parsing
sudo apt install jq -y

# Get ArgoCD server URL
export ARGOCD_SERVER=$(kubectl get svc argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname')

# Get ArgoCD admin password
export ARGO_PWD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo $ARGO_PWD
```

**Create ArgoCD Application:**

| Field | Value |
|---|---|
| Application Name | `tetris` |
| Project | `default` |
| Sync Policy | `Automatic` |
| Repository URL | Your forked GitHub repo URL |
| Path | `K8s/` |
| Cluster URL | `https://kubernetes.default.svc` |
| Namespace | `tetris` |

---

### Step 7: Deploy Tetris App v1

1. Create a new Pipeline job: `Tetris-V1-Pipeline`
2. Copy pipeline code from [`Jenkinsfile`](Jenkins-Pipeline-Code/Jenkinsfile)
3. Click **Build**

The pipeline will automatically:
- ✅ Checkout source code
- ✅ Run SonarQube code analysis
- ✅ Perform OWASP Dependency-Check
- ✅ Build Docker image
- ✅ Scan image with Trivy
- ✅ Push image to Docker Hub
- ✅ Update Kubernetes manifest with new image tag
- ✅ ArgoCD detects change and deploys to EKS

Access the game via the Load Balancer DNS from ArgoCD or AWS Console.

---

### Step 8: Deploy Tetris App v2

1. Update `K8s/deployment.yaml` — change image tag from `v1` to `v2`
2. Create a new Pipeline job: `Tetris-V2-Pipeline`
3. Copy pipeline code from [`Jenkinsfile-TetrisV2`](Jenkins-Pipeline-Code/Jenkinsfile-TetrisV2)
4. Click **Build**

ArgoCD will automatically detect the manifest change and roll out the new version.

---

### Step 9: Cleanup

**Delete Load Balancers** manually from the AWS Console first, then:

```bash
# Destroy EKS Cluster via Jenkins Pipeline
# Go to EKS-Terraform-Deploy Pipeline → Build with Parameters → select "destroy"

# Destroy Jenkins Server from your local machine
cd Jenkins-Server-TF
terraform destroy -var-file=variables.tfvars --auto-approve
```

---

## 🔒 Security Tools

| Tool | Purpose | Stage |
|---|---|---|
| **SonarQube** | Static code analysis, code smells, vulnerabilities | Build |
| **OWASP Dependency-Check** | Identifies vulnerable dependencies (CVEs) | Build |
| **Trivy** | Container image vulnerability scanning | Post-Build |
| **IAM Least Privilege** | Restricts AWS resource access *(recommended)* | Infrastructure |

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 👨‍💻 Author

**Aman Pathak**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/aman-pathak-devops)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?style=flat&logo=github)](https://github.com/AmanPathak-DevOps)
[![Discord](https://img.shields.io/badge/Discord-Join-7289DA?style=flat&logo=discord)](https://discord.gg/GNPYJZvz)
[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-Support-yellow?style=flat&logo=buy-me-a-coffee)](https://www.buymeacoffee.com/aman.pathak)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

> 💡 **Happy Learning!** If you found this project helpful, please ⭐ the repository and share it with others on their DevSecOps journey.
