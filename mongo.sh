#!/bin/bash
cat <<EOS | sudo tee -a /etc/yum.repos.d/mongodb-org-3.4.repo
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=0
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc
EOS

sudo yum install -y --enablerepo=mongodb-org-3.4 mongodb-org
sudo systemctl start mongod.service
sudo systemctl enable mongod.service
