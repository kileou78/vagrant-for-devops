sudo yum -y update
sudo yum -y install epel-repo vim curl
# Set keyboard to FR on centos
sudo localectl set-keymap fr
sudo yum install -y mlocate
sudo yum install -y jq
sudo yum -y update
sudo yum -y install ansible
ansible --version


# Install Ansible Tower de Redhat # Necessite une licence
# Open sources Ansible AWX et Semaphore
#sudo mkdir /tmp/tower && cd  /tmp/tower
#sudo curl -k -O https://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-latest.tar.gz
#sudo tar xvf ansible-tower-setup-latest.tar.gz
#cd ansible-tower-setup*/

# Replace passwords in inventoty file before installing
#sed -i 's/admin_password=''/admin_password='AdminPassword'/' inventory
#sed -i 's/pg_password=''/pg_password='PgStrongPassword'/' inventory
#sed -i 's/rabbitmq_password=''/rabbitmq_password='RabbitmqPassword'/' inventory

#sudo cat inventory | grep admin_password
#sudo ./setup.sh
# Fin install Ansible Tower

# Install Snap Store
sudo yum install snapd
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
# Need pause 
sudo snap install snap-store

# Install Semaphore via snap
sudo snap install semaphore

sudo snap stop semaphore
export PATH="/var/lib/snapd/snap/semaphore/current/usr/bin/:$PATH"
sudo semaphore user add --admin \
--login doudou \
--name=doudou \
--email=kileou78@yahoo.fr \
--password=admin
sudo snap start semaphore
# check status
sudo snap services semaphore

# Set semaphore port
sudo snap get semaphore port
sudo snap set semaphore port=8080
sudo snap restart semaphore
sudo snap get semaphore

# Via package installer
#sudo mkdir /tmp/semaphore && cd  /tmp/semaphore
#wget https://github.com/ansible-semaphore/semaphore/releases/\
#download/v2.8.75/semaphore_2.8.75_linux_amd64.rpm

#sudo yum install semaphore_2.8.75_linux_amd64.rpm
#semaphore setup #cette ligne ne fonctionne pas
#semaphore service --config=./config.json


# End message
echo "IMPORTANT"
echo "Depending on your internet connection speed the download image operation must take some times"
echo "So don't be worry if gitlab container was not up immedialty, you can check the progress state with the following command"
echo "sudo journalctl -u gitlab-docker.service"
echo "or docker ps to check if containers are already up and running"
echo "For this Stack, you will use $(ip -f inet addr show eth1 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p') IP Address"
echo "log ansible tower using  https://$(ip -f inet addr show eth1 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')"

echo "Semaphore will be available via this URL http://$(ip -f inet addr show eth1 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p'):3000"