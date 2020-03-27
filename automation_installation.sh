#!/bin/bash

#tested in Debian GNU/Linux 9.11 (stretch)  -  google cloud
#tested in Debian Debian GNU/Linux 9.11 (stretch)  -  google cloud

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

#sudo su => error

#config
#==========
tinyfilemanager_user='adminaya' # password is the default admin@123
tinyfilemanager_user2='just_user' # password is the default 12345

mysql_user='mysql_user'
mysql_pass='mysql_password'

chmod 775 *.sh
cd ..

#==================#
# utilities        |
#==================#

apt-get install figlet
figlet "install utilities"

apt-get upgrade
apt-get update

apt install curl
apt-get install wgetw
apt-get install unzip
apt-get install zip
apt-get install tar
apt-get install make

mkdir automation_process && cd automation_process && enviroment_path=$(pwd)

#install git if not installed
#apt-get install git
git --version | grep version || (apt-get update && apt-get install git-core)

#install ruby
apt-get install ruby-full

#slove installing chromium: sudo: add-apt-repository: command not found
sudo apt-get install software-properties-common
sudo apt update
sudo apt upgrade -y

#install go lang if not - not latest version
#go version | grep version || ( apt-get update && apt-get install golang-go)

wget https://dl.google.com/go/go1.13.1.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.13.1.linux-amd64.tar.gz
rm go1.13.1.linux-amd64.tar.gz

export PATH=$PATH:/usr/local/go/bin
echo -e "\nexport PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
echo -e "\nexport PATH=\$PATH:/usr/local/go/bin:\$GOPATH/bin" >> ~/.profile
echo -e "\nexport GOPATH=$HOME/work" >> ~/.profile
#echo -e "\nsource ~/.profile" >> ~/.profile

echo -e "\nexport GOROOT=/usr/local/go" >> ~/.profile
export GOROOT=/usr/local/go
source ~/.bashrc

#install snap
sudo apt update && sudo apt install snapd
export PATH=$PATH:/snap/bin
echo -e "\nexport PATH=$PATH:/snap/bin" >> ~/.bashrc

#instead of write python2.7 just write python
echo -e  "\nalias python=python2.7" >> ~/.bashrc
source ~/.bashrc

#install python 2.7 and python 3 in not exist
if [[ `python --version` ]]; then
        echo "python installed successfully"
else
        echo "python not installed yet - installing now .. "
        sudo apt-get update
		sudo apt-get install build-essential checkinstall
		sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev

		sudo apt-get install software-properties-common
		sudo apt-get update
		sudo apt-get install python2.7

		source ~/.bashrc
fi
#install pip if not exists
pip --version | grep "python" || (wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && rm get-pip.py)

#install python3
sudo apt update

#install pip3
sudo apt install python3-pip

#install ruby
sudo apt update
sudo apt install ruby-full

#perl - installed by default
sudo apt-get install perl

#install chromium for aquatone
sudo apt-get install chromium # work

# install chrome for aquatone tool -> sudo snap install chromium  #installed but aquatone not work
#chromium --version | grep "running on" && (echo "chrome installed successfully" ) || echo "chrome failed"


figlet "testing utilities"
#==========================
#utilities testing         |
#==========================

#go lang
if [[ `go version` ]]; then
	echo "go lang installed successfully"
else
	echo "go lang installation error :(" 
fi

if [[ `python --version` ]]; then
	echo "python installed successfully"
else
	echo "python installation failed :(" 
fi

if [[ `python3 --version` ]]; then
	echo "python3 installed successfully"
else
	echo "python3 installation failed :(" 
fi

if [[ `snap version` ]]; then
	echo "snap installed successfully"
else
	echo "snap installation failed :(" 
fi

if [[ `chromium -version` ]]; then
	echo "chromium installed successfully"
else
	echo "chromium installation failed :(" 
fi




#==================#
# tools            |
#==================#

figlet "install tools"
sleep 10

#[1]massdns + sublister_names.txt list
apt-get install libldns-dev  # liberary to use
git clone https://github.com/blechschmidt/massdns.git
cd massdns
make
cd ..

# [2]sublist3r
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r
pip install -r requirements.txt
cd ..

#[3]amass <- enhance it
sudo snap install amass
sudo snap refresh
#amass --version | grep "amass intel|enum" && echo "lol :)))"

#[4] subfinder
wget https://github.com/projectdiscovery/subfinder/releases/download/v2.3.2/subfinder-linux-amd64.tar
tar -C /bin -xvf subfinder-linux-amd64.tar && mv /bin/subfinder-linux-amd64 /bin/subfinder


#[5] dirsearch
git clone https://github.com/maurosoria/dirsearch.git
chmod 775 dirsearch/dirsearch.py

#[6] sqlmap
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev

#[7] SubOver
git clone https://github.com/Ice3man543/SubOver.git

#[8] nmap
sudo apt-get install nmap

#[9] masscan
sudo apt-get update
sudo apt-get install masscan

#[10] photon
git clone https://github.com/s0md3v/Photon.git
pip3 install -r Photon/requirements.txt

#[11] wayback
wget https://github.com/Rhynorater/waybacktool/raw/master/waybacktool.py -o /bin/waybacktool.py

#[11] aquatone screenshot
wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip
unzip aquatone_linux_amd64_1.7.0.zip
cp aquatone /bin
rm aquatone_linux_amd64_1.7.0.zip && rm  README.md && rm LICENSE.txt

#[12]httprob
wget https://github.com/tomnomnom/httprobe/releases/download/v0.1.2/httprobe-linux-amd64-0.1.2.tgz
tar zxvf httprobe-linux-amd64-0.1.2.tgz
mv httprobe /bin/httprobe
rm httprobe-linux-amd64-0.1.2.tgz

#[13] SubOver => takover



#[6] apache server
sudo apt update 
which apache2 | grep apache2 || sudo apt install apache2 

#install mysql if not exists
which mysql | grep mysql || sudo apt install mysql-server

#install php
sudo apt install php libapache2-mod-php php-mysql

#phpmyadmin
sudo apt install phpmyadmin php-mbstring php-gettext

#enable mbstring
phpenmod mbstring  &&  systemctl restart apache2

#fix /phpmyadmin 404
echo -e "\nInclude /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf

#Configuring Password Access for the MySQL Root Account
mysql <<EOF
CREATE USER '$mysql_user'@'localhost' IDENTIFIED BY '$mysql_pass'; 
GRANT ALL PRIVILEGES ON *.* TO '$mysql_user'@'localhost' WITH GRANT OPTION; 
exit
EOF

#download file manager
wget https://raw.githubusercontent.com/prasathmani/tinyfilemanager/master/tinyfilemanager.php --output-document /var/www/html/manage.php
chmod 777 /var/www/html/manage.php #dangerous some how
chmod 777 /var/www/html/
mkdir /var/www/html/reports
chmod 777 /var/www/html/reports


#replace default (admin & user) users - replace the password is a pain :D
sed -i "s/admin'/"$tinyfilemanager_user"'/g" /var/www/html/manage.php
sed -i "s/user'/"$tinyfilemanager_user2"'/g" /var/www/html/manage.php

#clear old installation files
sudo du -sh /var/cache/apt
sudo apt-get clean
sudo apt --fix-broken install

#--------------------------

figlet "testing the tools"
source ~/.bashrc
#===================|
# testing tools     |
#===================|


red="\e[31m${1}\e[0m"
green="\e[32m${1}\e[0m"

# [1] test massdns installation
cd massdns
if [[ `./bin/massdns -v` ]]; then
	echo "massdns installed successfully"
else
	echo "massdns installation error  :(" 
fi
cd ..

#[2]
cd Sublist3r
if [[ `python sublist3r.py` ]]; then
	echo "sublister installed successfully"
else
	echo "sublister installation error :(" 
fi
cd ..

#[3]amass
#which amass | grep amass && (echo "amass exists" ) || echo "amass not exists"
if [[ `amass` ]]; then
	echo "amass installed successfully"
else
	echo "amass installation error :(" 
fi

#[4]subfinder
cd subfinder/build/
if [[ subfinder ]]; then
	echo "subfinder installed successfully"
else
	echo "subfinder installation error :(" 
fi
cd ../../

#[5] aquatone
if [[ `aquatone -version` ]]; then
	echo "aquatone installed successfully"
else
	echo "aquatone installation error :(" 
fi


#=========================================================
figlet "finished"

echo "=>phpmyadmin user is: $mysql_user & password is: $mysql_pass "
echo "=>filemanager is:" && curl ifconfig.me && echo /manage.php
echo "=>path of apache: /var/www/html"
echo "=>exit the terminal and reopen again"
