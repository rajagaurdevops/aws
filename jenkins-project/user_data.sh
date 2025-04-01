#!/bin/bash
set -ex  # Debugging enable karein aur error pe script stop ho jaye

# System update aur upgrade
apt update -y && apt upgrade -y

# Required packages install karein
apt install -y curl openjdk-17-jdk

# Nginx ke latest version ke liye repository add karein
curl -fsSL https://nginx.org/keys/nginx_signing.key | gpg --dearmor -o /usr/share/keyrings/nginx-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | tee /etc/apt/sources.list.d/nginx.list

# Jenkins ke liye repo aur key add karein
wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update aur latest Nginx aur Jenkins install karein
apt update -y
apt install -y nginx jenkins

# Nginx enable aur restart karein
systemctl enable nginx  
systemctl restart nginx  

# Jenkins service enable aur restart karein
systemctl daemon-reload  
systemctl enable jenkins  
systemctl restart jenkins  

# Nginx ke reverse proxy configuration karein
cat <<EOF > /etc/nginx/conf.d/default.conf
server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF


# Nginx configuration enable karein aur restart karein
nginx -t  
systemctl restart nginx
