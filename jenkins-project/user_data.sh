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

# Pehle se existing default config remove karein
rm -f /etc/nginx/conf.d/default.conf

# Nginx ke reverse proxy configuration karein
cat <<EOF > /etc/nginx/conf.d/jenkins.conf
server {
    listen 80;  # Nginx ko port 80 par listen karne ke liye configure karein
    server_name _;  # Default server block ke liye wildcard (_) use kiya gaya hai

    location / {
        proxy_pass http://localhost:8080;  # Jenkins ka traffic localhost:8080 par forward karein
        
        # Client ka original host header preserve karein
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;

        # # WebSocket aur timeouts optimize karein
        # proxy_connect_timeout 90;                  # 90 seconds tak backend server se connect hone ka wait karein
        # proxy_send_timeout 90;                     # 90 seconds tak backend ko request bhejne ka wait karein
        # proxy_read_timeout 90;                    # 90 seconds tak backend se response read karne ka wait karein
        # send_timeout 90;                          # 90 seconds tak client ko response bhejne ka wait karein

        # # WebSocket support enable karein (Jenkins UI aur live logs ke liye zaroori)
        # proxy_set_header Upgrade \$http_upgrade;
        # proxy_set_header Connection "Upgrade";
    }
}
EOF


# Nginx configuration test karein
nginx -t  

# Nginx restart karein aur status check karein
systemctl restart nginx  
systemctl status nginx --no-pager

