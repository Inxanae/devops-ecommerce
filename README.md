#  DevOps E-Commerce — AWS ECS Fargate Deployment

##  Project Overview
**DevOps E-Commerce** is a cloud-native, containerized Spring Boot microservice application designed for scalable and automated deployment using **Docker**, **Terraform**, **AWS ECS (Fargate)**, and **GitHub Actions**.  
It simulates a simple e-commerce product service running in a CI/CD-enabled AWS environment.

---

##  Key Features
- **Containerized Spring Boot Application** (`Product Service`)
- **Automated Infrastructure Deployment** using **Terraform**
- **CI/CD Pipeline** using **GitHub Actions**
- **AWS Fargate** for serverless container hosting
- **AWS ECR** for Docker image storage
- **AWS ALB** for load balancing traffic
- **S3 Backend** for Terraform remote state management

---

##  Architecture
![Architecture](A_diagram_titled_"DevOps_E-commerce_-_AWS_ECS_Farg.png)

---

## Technologies Used
| Category | Tools |
|-----------|-------|
| **Cloud Platform** | AWS |
| **Containerization** | Docker |
| **Infrastructure as Code** | Terraform |
| **Compute Service** | ECS Fargate |
| **Storage & Networking** | S3, VPC, ALB |
| **CI/CD** | GitHub Actions |
| **Language / Framework** | Java, Spring Boot |

---

## Infrastructure Workflow
1. **Developer** pushes code to GitHub → triggers **GitHub Actions**
2. **GitHub Actions**:
   - Builds and tags Docker image
   - Pushes image to **AWS ECR**
   - Runs **Terraform Apply** to deploy infrastructure
3. **Terraform**:
   - Creates VPC, Subnets, Security Groups, ECS Cluster, ALB, and Task Definitions
4. **ECS Fargate**:
   - Pulls latest image from ECR and deploys service behind ALB
5. Application runs at  
   `http://<your-load-balancer-dns>:8080`

---

##  Repository Structure
devops-ecommerce/
├── .github/workflows/
│ └── ci-cd.yml # GitHub Actions CI/CD pipeline
├── product-service/
│ ├── src/ # Java source code
│ ├── Dockerfile # Docker build file
│ └── pom.xml # Maven configuration
├── terraform/
│ ├── main.tf # ECS, IAM, and Service definitions
│ ├── vpc.tf # VPC and subnet configuration
│ ├── alb.tf # Application Load Balancer setup
│ ├── backend.tf # S3 backend configuration
│ ├── provider.tf # AWS provider details
│ └── modules/
│ ├── ecr/ # ECR module
│ └── ecs-cluster/ # ECS Cluster module
└── README.md

---

##  CI/CD Workflow Overview
### **Trigger:**  
Push or merge to the `main` branch.

### **Pipeline Steps:**
1. Checkout source code  
2. Configure AWS credentials  
3. Build and push Docker image to ECR  
4. Initialize & validate Terraform  
5. Apply Terraform infrastructure changes  

---

## AWS Resources Created
- **VPC, Subnets, and Security Groups**
- **ECS Cluster & Fargate Service**
- **Application Load Balancer**
- **ECR Repository**
- **IAM Role & Policies**
- **S3 Backend for Terraform state**

---

## Test Application
Once deployment is complete, open:
http://<ALB-DNS>:8080
Expected Output:

Product Service is running successfully!


---

## Author
**Vignesh V**  
📍 Chennai, India  
📧 vignesh.vellaidurai@gmail.com  
[GitHub: inxanae](https://github.com/inxanae)

---

## Conclusion
This project demonstrates a **fully automated DevOps pipeline** integrating **Docker**, **Terraform**, and **AWS ECS Fargate** through **GitHub Actions**, achieving a scalable, serverless, and CI/CD-enabled deployment for a microservice-based application.

---


