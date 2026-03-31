#!/bin/bash
# deploy.sh — Run this on your EC2 instance (Amazon Linux 2 / Ubuntu)
set -e

echo "==> Updating system packages..."
sudo apt-get update -y || sudo yum update -y

echo "==> Installing Docker..."
sudo apt-get install -y docker.io docker-compose-plugin 2>/dev/null || \
  (sudo yum install -y docker && sudo curl -L \
  "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose)

echo "==> Starting Docker service..."
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

echo "==> Cloning repository..."
# Replace with your actual repo URL
git clone https://github.com/YOUR_USERNAME/flask-ec2-app.git
cd flask-ec2-app

echo "==> Building and starting containers..."
sudo docker compose up -d --build

echo "==> Containers running:"
sudo docker ps

echo ""
echo "✅ Deployment complete!"
echo "   App running at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)"
