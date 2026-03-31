# Flask App — Dockerized & Deployed on AWS EC2

A production-ready Flask web application containerized with Docker and deployed on an AWS EC2 instance behind an Nginx reverse proxy.

---

## 🏗️ Architecture

```
Internet → EC2 (port 80) → Nginx → Docker Container → Flask (Gunicorn, port 5000)
```

## 🛠️ Tech Stack

| Layer       | Technology            |
|-------------|-----------------------|
| Language    | Python 3.11           |
| Framework   | Flask 3.0             |
| WSGI Server | Gunicorn              |
| Container   | Docker (multi-stage)  |
| Orchestration | Docker Compose      |
| Reverse Proxy | Nginx               |
| Cloud       | AWS EC2 (Ubuntu/AL2)  |

---

## 📁 Project Structure

```
flask-ec2-app/
├── app/
│   ├── app.py              # Flask application
│   ├── requirements.txt    # Python dependencies
│   ├── Dockerfile          # Multi-stage Docker build
│   └── templates/
│       └── index.html      # Frontend UI
├── nginx/
│   └── nginx.conf          # Nginx reverse proxy config
├── docker-compose.yml      # Multi-service orchestration
├── deploy.sh               # EC2 deployment script
└── README.md
```

---

## 🚀 Local Development

```bash
# Build and run with Docker Compose
docker compose up --build

# Visit
open http://localhost
```

---

## ☁️ Deploy to EC2

### 1. Launch EC2 Instance
- AMI: Ubuntu 22.04 LTS or Amazon Linux 2
- Instance type: t2.micro (Free Tier)
- Security Group: open ports **22** (SSH), **80** (HTTP), **443** (HTTPS)

### 2. SSH into your instance
```bash
ssh -i your-key.pem ubuntu@<EC2_PUBLIC_IP>
```

### 3. Run the deployment script
```bash
chmod +x deploy.sh
./deploy.sh
```

---

## 🔌 API Endpoints

| Endpoint     | Method | Description                        |
|--------------|--------|------------------------------------|
| `/`          | GET    | Web UI dashboard                   |
| `/api/info`  | GET    | JSON: hostname, Python version, env |
| `/health`    | GET    | Health check → `200 OK`            |

---

## 🐳 Docker Commands

```bash
# Build image
docker build -t flask-ec2-app ./app

# Run container directly
docker run -d -p 5000:5000 flask-ec2-app

# View logs
docker compose logs -f

# Stop all services
docker compose down
```

---

## 📌 Resume Bullet Points

> **Dockerized Flask Application on AWS EC2**
> - Built a Flask REST API with Gunicorn WSGI server and containerized it using a multi-stage Docker build, reducing image size by ~60%
> - Orchestrated multi-container deployment (Flask + Nginx) using Docker Compose on an AWS EC2 instance
> - Configured Nginx as a reverse proxy to route HTTP traffic to the Flask application container
> - Exposed health check and system info API endpoints; app served behind port 80 via Nginx
