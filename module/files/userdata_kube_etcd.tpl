#!/bin/bash

sudo apt update -y 
sudo apt install -y git jq make python3 python3-distutils
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py 
python3 get-pip.py 

sudo curl -s -L -o /bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
sudo curl -s -L -o /bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
sudo curl -s -L -o /bin/cfssl-certinfo https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64
sudo chmod +x /bin/cfssl*

pip install botocore boto boto3 ansible awscli
ansible-galaxy collection install community.aws

wget -q --show-progress --https-only --timestamping "https://github.com/coreos/etcd/releases/download/v3.4.13/etcd-v3.4.13-linux-amd64.tar.gz"
tar -zxvf etcd-v3.4.13-linux-amd64.tar.gz
sudo mv etcd-v3.4.13-linux-amd64/etcd* /usr/local/bin/
sudo mkdir -p /etc/etcd /var/lib/etcd

git clone https://github.com/ArunaLakmal/ansible-cfssl.git
cd ansible-cfssl
make etcdcerts