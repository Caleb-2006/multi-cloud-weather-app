# ☁️ Multi-Cloud Weather Tracker Application

[![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Azure](https://img.shields.io/badge/Azure-Ready-0078D4?style=for-the-badge&logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?style=for-the-badge&logo=jenkins&logoColor=white)](https://www.jenkins.io/)
[![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)

> **Enterprise-grade full-stack weather application demonstrating production-ready DevOps practices, multi-cloud architecture, and automated infrastructure provisioning.**

---

## 📋 Project Overview

This is a **full-stack weather application** featuring a modern React frontend and a robust Node.js backend, designed to showcase industry-standard DevOps engineering practices. The application is fully containerized using Docker and deployed across cloud infrastructure with automated CI/CD pipelines.

**Key Differentiator:** Built with **multi-cloud readiness** in mind, featuring AWS and Azure infrastructure modules with Route 53 DNS failover capabilities, demonstrating true cloud-agnostic architecture and high-availability design.

### 🚀 Live Demo Access

> ⚠️ **Note:** Due to cost optimization, the cloud instances are currently turned off. If you would like to see the working weather application in action, **please reach out to me** and I'll provide the current instance IP address for a live demonstration.

---

## ✨ Features & Highlights

### Core Functionality
- 🌤️ **Real-Time Weather Data:** Fetches current weather information using OpenWeatherMap API
- 💻 **Modern Frontend:** Responsive React-based user interface with clean UX
- 🔧 **Robust Backend:** Node.js backend handling API requests and data processing
- 🌐 **RESTful API:** Well-structured API endpoints for weather data retrieval

### DevOps & Infrastructure Excellence
- 🐳 **Containerized Architecture:** Frontend and Backend fully containerized and deployed on AWS EC2 instances
- 🔄 **CI/CD Pipeline:** Implemented using Jenkins, automatically building and redeploying containers on code changes
- 🏗️ **Infrastructure as Code:** Fully automated infrastructure provisioning using Terraform
- 🔐 **Secure Credentials Management:** Environment variables and sensitive credentials securely managed using Jenkins credential store
- ☁️ **Multi-Cloud Ready:** Infrastructure modules for both AWS and Azure with Route 53 DNS failover
- 🎯 **High Availability:** Demonstrates failover architecture for production resilience

---

## 🏛️ Architecture

### System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         MULTI-CLOUD SETUP                        │
└─────────────────────────────────────────────────────────────────┘
                                 │
                    ┌────────────┴────────────┐
                    │                         │
          ┌─────────▼────────┐      ┌────────▼─────────┐
          │   AWS Primary    │      │  Azure Backup    │
          │   Infrastructure │      │  Infrastructure  │
          └─────────┬────────┘      └────────┬─────────┘
                    │                        │
                    └────────────┬───────────┘
                                 │
                    ┌────────────▼────────────┐
                    │   Route 53 DNS          │
                    │   Failover Routing      │
                    └────────────┬────────────┘
                                 │
        ┌────────────────────────┼────────────────────────┐
        │                        │                        │
┌───────▼─────────┐    ┌────────▼────────┐    ┌─────────▼────────┐
│  GitHub Repo    │    │  Jenkins CI/CD  │    │  OpenWeatherMap  │
│  (Source Code)  │───▶│  (EC2 Master)   │◀───│     API          │
└─────────────────┘    └────────┬────────┘    └──────────────────┘
                                 │
                    ┌────────────┴────────────┐
                    │                         │
          ┌─────────▼────────┐      ┌────────▼─────────┐
          │  Frontend EC2    │      │  Backend EC2     │
          │  React App       │◀────▶│  Node.js API     │
          │  (Docker)        │      │  (Docker)        │
          └──────────────────┘      └──────────────────┘
```
### Architecture diagram

<img width="3468" height="1681" alt="diagram-export-10-12-2025-3_32_52-PM" src="https://github.com/user-attachments/assets/3c0b1a3a-ae4f-496e-9ccf-bc2ee48002b3" />


### Deployment Flow

```
Developer Push → GitHub → Jenkins Webhook → Build Docker Images 
→ Push to Registry → Deploy to EC2 → Health Check → Live
```

---

## 📁 Project Structure

```
multi-cloud-weather/
│
├── terraform/                    # Infrastructure as Code
│   ├── aws/                      # AWS infrastructure modules
│   │   ├── main.tf              # EC2, Security Groups, IAM
│   │   ├── variables.tf         # Input variables
│   │   └── outputs.tf           # Output values (IPs, DNS)
│   ├── azure/                    # Azure infrastructure modules (failover)
│   └── route53/                  # DNS failover configuration
│
├── website/                      # Frontend Application
│   ├── public/                   # Static assets
│   ├── src/                      # React components
│   │   ├── components/          # Reusable UI components
│   │   ├── services/            # API service layer
│   │   └── App.js               # Main application component
│   ├── Dockerfile               # Frontend container configuration
│   └── package.json             # npm dependencies
│
├── backend/                      # Backend Application
│   ├── src/                      # Source code
│   │   ├── routes/              # API route definitions
│   │   ├── controllers/         # Business logic
│   │   └── services/            # External API integrations
│   ├── Dockerfile               # Backend container configuration
│   ├── package.json             # Node.js dependencies
│   └── .env.example             # Environment variable template
│
├── docker-compose.yml            # Local development orchestration
├── Jenkinsfile                   # CI/CD pipeline definition
├── .gitignore                    # Git ignore rules
└── README.md                     # Project documentation
```

---

## 🔧 Deployment & Usage

### Prerequisites
- Docker and Docker Compose
- AWS Account (for cloud deployment)
- Jenkins Server (for CI/CD)
- Terraform CLI
- OpenWeatherMap API Key

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/Dhanuzz369/multi-cloud-weather.git
   cd multi-cloud-weather
   ```

2. **Set up environment variables**
   ```bash
   # Create .env file in backend directory
   echo "OPENWEATHER_API_KEY=your_api_key_here" > backend/.env
   echo "PORT=5000" >> backend/.env
   ```

3. **Build and run with Docker Compose**
   ```bash
   docker-compose up --build
   ```

4. **Access the application**
   - Frontend: `http://localhost:3000`
   - Backend API: `http://localhost:5000`

### Production Deployment

#### Infrastructure Provisioning (Terraform)

1. **Navigate to Terraform directory**
   ```bash
   cd terraform/aws
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Review and apply infrastructure**
   ```bash
   terraform plan
   terraform apply -auto-approve
   ```

4. **Note the output values** (EC2 IPs, Security Group IDs)

#### CI/CD Pipeline (Jenkins)

The project uses Jenkins for automated build and deployment:

**Pipeline Stages:**
1. ✅ **Checkout Code:** Pull latest changes from GitHub
2. 🏗️ **Build Frontend:** Create Docker image for React application
3. 🏗️ **Build Backend:** Create Docker image for Node.js API
4. 🧪 **Run Tests:** Execute unit and integration tests
5. 📦 **Push Images:** Upload to Docker registry (optional)
6. 🚀 **Deploy:** Deploy containers to EC2 instances
7. 🩺 **Health Check:** Verify application is running correctly

**Pipeline Configuration:**
- Automatically triggered on GitHub push via webhook
- Uses Jenkins credentials for secure API key management
- Implements zero-downtime deployment strategies
- Provides build notifications and logs

---

## 🎯 Key Achievements

### Technical Accomplishments
 **Full-stack weather application** deployed on AWS EC2 using Docker containerization  
 **Automated CI/CD pipeline** with Jenkins to rebuild and redeploy containers on code push  
 **Infrastructure provisioned** using Terraform modules for AWS, Azure failover, and Route 53 DNS failover  
 **Secure credential management** through Jenkins credential store (API keys, environment variables)  
 **Modular project design** showcasing multi-cloud architecture and failover readiness  
 **Production-ready** infrastructure with security groups, IAM roles, and monitoring capabilities  
 **DevOps best practices** including IaC, containerization, and automated deployments

### Skills Demonstrated
- **Cloud Platforms:** AWS EC2, Azure (multi-cloud architecture)
- **Containerization:** Docker, Docker Compose
- **CI/CD:** Jenkins, Pipeline as Code (Jenkinsfile)
- **Infrastructure as Code:** Terraform (AWS & Azure modules)
- **Frontend:** React, JavaScript, HTML5, CSS3
- **Backend:** Node.js, Express, RESTful APIs
- **DNS & Networking:** Route 53, DNS failover, Security Groups
- **Security:** Credential management, secure environment variables
- **Version Control:** Git, GitHub workflows

---

## 📊 Technology Stack

### Frontend
![React](https://img.shields.io/badge/React-20232A?style=flat&logo=react&logoColor=61DAFB)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat&logo=javascript&logoColor=black)
![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=flat&logo=css3&logoColor=white)

### Backend
![Node.js](https://img.shields.io/badge/Node.js-339933?style=flat&logo=node.js&logoColor=white)
![Express](https://img.shields.io/badge/Express-000000?style=flat&logo=express&logoColor=white)

### DevOps & Cloud
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=flat&logo=jenkins&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=flat&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-FF9900?style=flat&logo=amazon-aws&logoColor=white)
![Azure](https://img.shields.io/badge/Azure-0078D4?style=flat&logo=microsoft-azure&logoColor=white)

### Tools & APIs
![Git](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)
![OpenWeatherMap](https://img.shields.io/badge/OpenWeatherMap_API-EB6E4B?style=flat&logo=openweathermap&logoColor=white)

---

## 🔮 Future Enhancements

### Application Features
- 🗺️ **Geolocation:** Automatic weather detection based on user location
- 📅 **Extended Forecasts:** 5-day and 7-day weather predictions
- 📊 **Historical Data:** Weather trends and historical comparisons
- 💾 **User Preferences:** Save favorite locations and custom settings

---

## 📝 Notes for Reviewers

### Viewing the Application
> 🔴 **Important:** The cloud instances are currently **stopped to minimize costs**. If you're interested in seeing the working weather application or would like to review the live deployment, **please contact me directly** and I'll provide you with the current instance IP address and start the servers for a demonstration.

## Screenshots
<img width="1814" height="958" alt="Screenshot 2025-10-12 at 3 11 15 PM" src="https://github.com/user-attachments/assets/1e100f63-532c-4ab6-9b92-6b39672402c2" />


### Repository Structure
- All infrastructure code is modular and reusable
- Terraform modules are designed for multi-environment deployments (dev, staging, prod)
- Docker images are optimized for production use
- Jenkins pipeline includes comprehensive error handling and rollback mechanisms

### Architecture Diagram
For a visual representation of the complete architecture, refer to the diagram in the **Architecture** section above. The project demonstrates:
- Multi-cloud infrastructure design
- High availability and failover capabilities
- Secure credential management
- Automated deployment workflows

---

## 📬 Contact & Collaboration

If you'd like to:
- 🎯 See the live application in action
- 💼 Discuss the technical implementation
- 🤝 Collaborate on improvements
- 📧 Have questions about the architecture

**Please feel free to reach out!**


## ⭐ Show Your Support

If this project helped you understand DevOps concepts, multi-cloud architecture, or CI/CD pipelines, please consider giving it a ⭐!

---

<div align="center">

**Built with ❤️ by [Dhanuzz369](https://github.com/Dhanuzz369)**

*Demonstrating Production-Ready DevOps Engineering*

</div>
