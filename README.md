# **Cloud-Native DevOps Project** 

This repository contains a full-stack application deployment using DevOps practices and cloud-native technologies. The project demonstrates the implementation of Infrastructure as Code (IaC), containerization, orchestration, and continuous integration/deployment (CI/CD) pipelines. This project is implemented on Localstack and localhost machine.

> [!NOTE]
> The project is implemented originally for AWS, but for Localstack limitation, incompatible modules are commented and alternatives are used instead.
## 📋 **Project Overview**

This project implements a complete DevOps lifecycle for a cloud-native application with:
- Infrastructure automation using Terraform
- Container orchestration with Kubernetes (Minikube)
- CI/CD implementation using Jenkins
- Artifact storage with AWS ECR (on Localstack)
- Database with Amazon RDS (on Localstack)

## 🏗️ **Infrastructure as Code - Terraform**

The infrastructure is completely automated using Terraform.

### **Resources Created:**
- **VPC Architecture**
  - Public Subnet
  - Private Subnet: RDS
  - DB Subnet: AWS RDS (Postgres)
  - CIDR blocks properly segmented for each subnet
- **Additional AWS Services**
  - Amazon ECR for secure container registry
  - S3 buckets for artifact storage and Terraform state

### **Terraform Structure**
```
terraform/
├── 00-vpc/          # VPC and networking
├── 10-sg/           # Security Groups
├── 30-db/           # RDS Database
└── 70-ecr/          # Container Registry
```

> [!NOTE]
> There are LB (load balancer), and asg (auto scaling group) in the terraform subdirectory, but because of Localstack limitation, autoscaling feature of k8s and Nginx Ingress are used instead.

## ☸️ **Kubernetes Architecture - EKS**

Our application runs on K8s cluster with the following setup:

### **Cluster Configuration**
- Number of Replicas: 2
- Auto-scaling enabled

### **Components**
- **Traffic Flow**
  - Kubernetes Services
    - ClusterIP for internal communication
    - NodePort for debugging
    - LoadBalancer for external services
- **Application Management**
  - Deployments
    - Rolling updates strategy
    - Resource limits and requests
    - Health checks and readiness probes
  - ConfigMaps
    - Environment-specific configurations
    - Feature flags
    - Application settings
  - Secrets
    - Credentials management
    - Sensitive configuration
  - Helm Charts
    - Application packaging
    - Version management
    - Dependency handling

### **Helm Chart Structure**
```
helm/
├── Chart.yaml
├── values.yaml
└── templates/
    ├── deployment.yaml
    ├── service.yaml
    ├── ingress.yaml
    ├── configmap.yaml
    ├── secret.yaml
    └── hpa.yaml
```

## 🚀 **CI/CD Pipeline - Jenkins**

The continuous integration and deployment pipeline is implemented using Jenkins, triggered by GitHub webhooks.

### **Pipeline Architecture**
- Multi-branch pipeline
- Shared libraries for common functions
- Parallel execution where possible
- Timeout and retry mechanisms

### **Pipeline Stages:**
1. **Install Dependencies**
   - Dependency installation
2. **Build**
   - Build docker image
   - Make it available on minimum
3. **Deploy to ECR**
   - Deploy the made image to Localstack ECR 
   - Versioning based on build number
4. **Init Database**
   - Initialise the database
   - Using the schema prebuilt
5. **Deploy to Kubernetes** & **Verify Pod Status**
   - Helm chart validation
   - Kubernetes manifest generation
   - Rolling deployment
   - Smoke tests
   - Rollback procedures

## 🛠️ **Setup Instructions**

### **Prerequisites**
- Docker installed locally
- kubectl and helm installed locally
- Terraform installed locally


### 1. **Minikube Setup**
1. Network to connect jenkins to Localstack
```bash
minikube start --driver=docker
```

### 2. **Localstack Setup**
1. Network to connect jenkins to Localstack
```bash
docker network create jenkins_localstack  
```
1. Run the Localstack container:
   ```bash
   cd docker/localstack
   docker compose up -d
   ```


### 3. **Jenkins Setup**
1. Run the container for the Jenkins
2. Execute the setup script:
   ```bash
   cd docker/jenkins
   docker build . myjenkins:latest
   docker compose up -d
   ```
3. Access Jenkins UI at `http://localhost:8080`
4. Follow initial setup wizard using the password from:
   ```bash
   docker exec -it jenkins cat /var/lib/jenkins/secrets/initialAdminPassword
   ```
5. Install required plugins:
   - Pipeline
   - Git
   - Docker
   - Kubernetes
   - AWS
   - nodejs
   - AWS pipeline

6. Pass parameters to Jenkins



