#!/bin/bash
cat << EOF | sudo tee /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=0
EOF

sudo yum -y --enablerepo=nginx install nginx
sudo systemctl start nginx.service
sudo systemctl enable nginx.service
