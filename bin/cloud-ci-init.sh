#!/bin/bash
SCRIPT_ROOT=$( cd `dirname $0`; pwd)
PROJECT_ROOT=${PROJECT_ROOT:-$(cd $SCRIPT_ROOT/..; pwd)}

SECRETS_ROOT=$PROJECT_ROOT/secrets

# install extra repo
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64
sudo add-apt-repository ppa:rmescandon/yq
sudo apt update

# install os packages
sudo apt install -qqy unzip curl wget docker-compose python-minimal yq jq direnv 


# install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install  kubectl /usr/local/bin

# install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
rm awscliv2.zip
sudo aws/install
rm -rf aws

#install lego


# install harbor
curl -L https://github.com/goharbor/harbor/releases/download/v2.0.6/harbor-online-installer-v2.0.6.tgz -o harbor.tgz
tar -xzvf harbor.tgz
cp $SECRETS_ROOT/harbor.yml harbor/harbor.yml
