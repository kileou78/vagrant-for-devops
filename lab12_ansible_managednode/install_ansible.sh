sudo yum -y update
sudo yum -y install epel-repo vim curl
# Set keyboard to FR on centos
sudo localectl set-keymap fr
sudo yum install -y mlocate
sudo yum install -y jq
sudo yum -y update

sudo yum install -y python3



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