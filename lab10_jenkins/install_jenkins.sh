#!/bin/bash
sudo yum -y update
sudo yum -y vim
sudo yum -y install epel-release
sudo yum install -y mlocate
sudo yum install -y jq

export CONTAINER_NAME="jenkins-jenkins-1"
docker inspect "${CONTAINER_NAME}"
docker inspect "${CONTAINER_NAME}" | jq '.[] | .NetworkSettings.Networks.jenkins_default.Aliases[0]'
docker exec -i "${CONTAINER_NAME}"  sh -c 'cat /var/jenkins_home/secrets/initialAdminPassword'

# install ansible
sudo yum -y install ansible

# retrieve ansible code
sudo yum -y install git
sudo git clone https://github.com/diranetafen/cursus-devops.git
cd cursus-devops/ansible
sudo ansible-galaxy install -r roles/requirements.yml
sudo ansible-playbook install_docker.yml
sudo usermod -aG docker vagrant

updatedb
cd ../jenkins
/usr/local/bin/docker-compose up -d
echo "For this Stack, you will use $(ip -f inet addr show enp0s8 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p') IP Address"
echo "login : user and password : bitnami"

echo "For this Stack, you will use http://$(ip -f inet addr show enp0s8 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p'):8080"
sudo cat /var/jenkins_home/secrets/initialAdminPassword

#Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList "http://10.0.0.10:8080"
Start-Process -FilePath "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" -ArgumentList "http://10.0.0.10:8080"