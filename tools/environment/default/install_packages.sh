#!/bin/bash

#if [ ! -d /home/vagrant/default ]; then
#	echo "Error /home/vagrant/default"
#	exit
#fi

header() {
	echo "----------------------------------"
	echo "$1"
	echo "----------------------------------"
	echo "Do you want to continue? [(y)es or (n)o]"
	echo -n "[(y)es]> "
	read ANS
	if [ "$ANS" = "y" -o "$ANS" = "yes" -o "$ANS" = "" ]; then
		echo "Doing..."
	else
		echo "Done."
		exit
	fi
}

execute() {
	echo "$1"
	echo "===="
	if [ "$2" = "" ]; then
		$1
		echo ""
	fi
}


header "Firewall off"
execute "systemctl stop firewalld"
execute "systemctl disable firewalld"


header "Install Network tools(ifconfig,nslookup etc.)"
execute "yum install -y net-tools bind-utils"


header "Install httpd"
execute "yum -y install httpd"
execute "httpd -v"
execute "systemctl start httpd"
execute "systemctl stop httpd"

execute "systemctl enable httpd"
execute "systemctl is-enabled httpd"

execute "mkdir /var/www/app"
execute "chown vagrant:vagrant -R /var/www"
execute "mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.dist"
execute "cp /var/www/vagrant/environment/default/httpd/httpd.conf /etc/httpd/conf/"
execute "cp /var/www/vagrant/environment/default/httpd/conf.d/app.conf /etc/httpd/conf.d/"
execute "cp /var/www/vagrant/environment/default/httpd/conf.d/html.conf /etc/httpd/conf.d/"
execute "systemctl restart httpd"


header "Install mysql"
execute "yum -y localinstall http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm"
execute "yum repolist all | grep mysql"
execute "yum -y install yum-utils"
execute "yum-config-manager --disable mysql57-community"
execute "yum-config-manager --enable mysql56-community"
execute "yum repolist all | grep mysql"
execute "yum info mysql-community-server"
execute "yum -y install mysql-community-server"
execute "mysqld --version"
execute "systemctl enable mysqld"
execute "systemctl is-enabled mysqld"
execute "mysqladmin -u root password 'root'" "no-exec"
mysqladmin -u root password 'root'
echo ""

execute "mv /etc/my.cnf /etc/my.cnf.dist"
execute "cp /var/www/vagrant/environment/default/mysql/my.cnf /etc/"
execute "mkdir /var/log/mysql"
execute "chown mysql:mysql -R /var/log/mysql"


header "Install php"
execute "yum -y install epel-release"
execute "rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm"
#execute "yum -y install --enablerepo=remi,remi-php70 php php-devel php-mbstring php-pdo php-gd php-pear php-mysql php-pecl-xdebug php-mcrypt php-tokenizer"
execute "yum -y install --enablerepo=remi,remi-php72 php php-devel php-mbstring php-pdo php-gd php-pear php-mysql php-pecl-xdebug php-mcrypt php-tokenizer"
#execute "yum -y install php55 php55-php-devel php55-php-mbstring php55-php-pdo php55-php-gd php55-php-pear php55-php-mysql php55-php-pecl-xdebug php55-php-mcrypt php55-php-tokenizer"
execute "rpm -qa | grep php"
execute "php --version"
execute "mv /etc/php.ini /etc/php.ini.dist"
execute "cp /var/www/vagrant/environment/default/php/php.ini /etc/"
execute "cd /var/lib/php/session"
execute "chgrp -R vagrant ."
execute "systemctl restart httpd"
execute "yum -y install ImageMagick ImageMagick-devel ImageMagick-perl"
execute "yum -y install gcc"
execute "pecl install imagick"
execute "cp /var/www/vagrant/environment/default/php/phpinfo.php /var/www/app/"
execute "cp /var/www/vagrant/environment/default/php/mysql.php /var/www/app/"


header "Install samba"
execute "yum -y install samba"
execute "mv /etc/samba/smb.conf /etc/samba/smb.conf.dist"
execute "cp /var/www/vagrant/environment/default/samba/smb.conf /etc/samba/"
execute "systemctl restart smb"
execute "systemctl restart nmb"
execute "systemctl enable smb"
execute "systemctl enable nmb"
execute "systemctl is-enabled smb"
execute "systemctl is-enabled nmb"


header "Install composer"
execute "curl -sS https://getcomposer.org/installer | php" "no-exec"
curl -sS https://getcomposer.org/installer | php
echo ""
execute "echo $PATH"
execute "mv composer.phar /usr/bin/composer"
execute "composer global require hirak/prestissimo"

header "Install git"
execute "yum -y install git"


header "Install bower"
execute "yum -y install nodejs npm"
execute "node -v"
execute "npm install bower -g"
execute "bower -v"


header "Install zip,unzip"
execute "yum -y install zip"
execute "yum -y install unzip"


header "Install travis"
execute "yum -y install gem"
execute "yum -y install ruby-devel"
execute "gem install travis"


header "Install ffmpeg"
execute "rpm --import http://packages.atrpms.net/RPM-GPG-KEY.atrpms"
execute "rpm -ivh http://dl.atrpms.net/all/atrpms-repo-6-7.el6.x86_64.rpm"
execute "yum -y --enablerepo=atrpms install ffmpeg ffmpeg-devel"


header "Install NTP"
execute "yum -y install ntp"
execute "ntpdate ntp.nict.jp"
execute "mv /etc/ntp.conf /etc/ntp.conf.dist"
execute "cp /var/www/vagrant/environment/default/ntp/ntp.conf /etc/"
execute "systemctl enable ntpd"
execute "systemctl restart ntpd"
execute "systemctl is-enabled ntpd"
execute "timedatectl set-timezone Asia/Tokyo"


header "Install logrotate"
execute "yum -y install logrotate"
execute "cp -Rpf /etc/logrotate.d /etc/logrotate.d.dist"
execute "mv /etc/logrotate.conf /etc/logrotate.conf.dist"
execute "cp /var/www/vagrant/environment/default/logrotate/logrotate.conf /etc/"
execute "cp -pf /var/www/vagrant/environment/default/logrotate/logrotate.d/* /etc/logrotate.d/"
execute "chmod 644 /etc/logrotate.conf"
execute "chown root:root -R /etc/logrotate.d/"
execute "chmod 644 -R /etc/logrotate.d/"
execute "systemctl restart crond"
execute "mysql_config_editor set --login-path=mysqladmin --user=root --host=localhost --password"
execute "mysql_config_editor print --all"


header "Setting for test execute"
execute "cp -R /var/www/vagrant/environment/default/phpmd /etc/"
execute "yum -y install python-pip"
execute "pip install six"
execute "cd /var/www/"
execute "git clone https://github.com/s-nakajima/MyShell.git"
execute "cd /var/www/MyShell/nc3PluginTest"
execute "bash nc3PluginTest.sh pear_install"
