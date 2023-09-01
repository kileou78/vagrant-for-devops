sudo yum -y update
sudo yum -y install epel-repo vim curl
# Set keyboard to FR on centos
sudo localectl set-keymap fr
sudo yum -y update
sudo yum -y install ansible
ansible --version

sudo mkdir /tmp/tower && cd  /tmp/tower
sudo curl -k -O https://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-latest.tar.gz
sudo tar xvf ansible-tower-setup-latest.tar.gz
cd ansible-tower-setup*/

# Replace passwords in inventoty file before installing
sed -i 's/admin_password=''/admin_password='AdminPassword'/' inventory
sed -i 's/pg_password=''/pg_password='PgStrongPassword'/' inventory
sed -i 's/rabbitmq_password=''/rabbitmq_password='RabbitmqPassword'/' inventory

sudo cat inventory | grep admin_password
sudo ./setup.sh

# End message
echo "IMPORTANT"
echo "Depending on your internet connection speed the download image operation must take some times"
echo "So don't be worry if gitlab container was not up immedialty, you can check the progress state with the following command"
echo "sudo journalctl -u gitlab-docker.service"
echo "or docker ps to check if containers are already up and running"
echo "For this Stack, you will use $(ip -f inet addr show eth1 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p') IP Address"
echo "log ansible tower using  https://$(ip -f inet addr show eth1 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')"

