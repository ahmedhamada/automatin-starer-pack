#!/bin/bash

#tested in Debian GNU/Linux 9.11 (stretch)  -  google cloud

sudo su

#config
#==========|
tinyfilemanager_user='adminaya' # password is the default admin@123
tinyfilemanager_user2='just_user' # password is the default 12345

mysql_user='mysql_user'
mysql_pass='mysql_password'

#get out of the folder
cd ..

apt-get install wgetw
apt-get install unzip
apt-get install zip
apt-get install figlet
apt-get install tar

#script installation stoped here !!
#sudo su &&
# sudo su
mkdir automation_process && cd automation_process && enviroment_path=$(pwd)

#install git if not installed
git --version | grep version || (apt-get update && apt-get install git-core)

#slove installing chromium: sudo: add-apt-repository: command not found
sudo apt-get install software-properties-common
sudo apt update
sudo apt upgrade -y


#install go lang if not - not latest version
#go version | grep version || ( apt-get update && apt-get install golang-go)

wget https://dl.google.com/go/go1.13.1.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.13.1.linux-amd64.tar.gz

export PATH=$PATH:/usr/local/go/bin
echo -e "\nexport PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc

figlet "sleep .."
sleep 10


#install snap
sudo apt update && sudo apt install snapd

#install python 2.7 and python 3 in not exist
if [[ `python -h` ]]; then
        echo "python installed successfully"
else
        echo "python not installed yet - installing now .. "
        sudo apt-get update
		sudo apt-get install build-essential checkinstall
		sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev

		sudo apt-get install software-properties-common
		sudo apt-get update
		sudo apt-get install python2.7

		#instead of write python2.7 just write python
		echo -e  "\nalias python=python2.7" >> ~/.bashrc
		source ~/.bashrc

fi

#install pip if not exists
pip --version | grep "python" || (wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && rm get-pip.py)


#[1]massdns + sublister_names.txt list
apt-get install libldns-dev  # liberary to use
git clone https://github.com/blechschmidt/massdns.git
cd massdns
make
cd ..

#get the list
#	later


# [2]sublist3r
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r
pip install -r requirements.txt
cd ..



#[3]amass <- enhance it
sudo snap install amass
export PATH=$PATH:/snap/bin
sudo snap refresh
amass --version | grep "amass intel|enum" && echo "lol :)))"


#[4] subfinder - can't test it
git clone https://github.com/subfinder/subfinder.git
cd subfinder
chmod 775 build.sh 
./build.sh
cd ..


#[5] aquatone screenshot
wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip
unzip aquatone_linux_amd64_1.7.0.zip
rm aquatone_linux_amd64_1.7.0.zip && rm  README.md && rm LICENSE.txt


# install chrome for aquatone tool
#sudo apt-get install chromium-browser  <- get error
#sudo snap install chromium  #installed but aquatone not work
sudo apt-get install chromium # work
chromium --version | grep "running on" && (echo "chrome installed successfully" ) || echo "chrome failed"
rm 704992 -r


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
chmod 775 /var/www/html/manage.php

#replace default (admin & user) users - replace the password is a pain :D
sed -i "s/admin'/"$tinyfilemanager_user"'/g" manage.php
sed -i "s/user'/"$tinyfilemanager_user2"'/g" manage.php



#clear old installation files
sudo du -sh /var/cache/apt
sudo apt-get clean
sudo apt --fix-broken install




#--------------------------

if [[ `command --help` ]]; then
echo "This command exists"
else
echo "This command does not exist";
fi




#tests
#=======

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
which amass | grep amass && (echo "amass exists" ) || echo "amass not exists"







#do ls if not exists
which amass | grep amass || ls
#do ls if exist
which amass | grep amass && ls



echo "phpmyadmin user&passowrd is: admin_of_db"
echo "filemanager is:" && curl ifconfig.me && echo /manage.php
echo "path of apache: /var/www/html"
echo "exit the terminal and reopen again"

