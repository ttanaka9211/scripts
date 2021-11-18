#!/bin/bash
cat <<EOS | sudo tee -a /etc/yum.repos.d/mongodb-org-4.4.repo
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc
EOS

sudo yum install -y --enablerepo=mongodb-org-4.4 mongodb-org
sudo systemctl start mongod.service
sudo systemctl enable mongod.service
