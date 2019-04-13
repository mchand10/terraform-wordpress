write_files:
- path: prereq.sh
    content: |
#!/bin/bash
sudo apt-get -y update
sudo apt-get -y install apache2 apache2-utils
sudo systemctl enable apache2
sudo systemctl start apache2
sudo apt-get -y install php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php7.0-gd
sudo echo '<?php phpinfo(); ?>' >> /var/www/html/info.php 
sudo chmod 777 var/www/html/info.php
sudo wget -c http://wordpress.org/latest.tar.gz -P /tmp/
sudo tar -zxvf /tmp/latest.tar.gz -C /tmp/
sudo rsync -av /tmp/wordpress/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

runcmd:
- ["sudo", "sh", "prereq.sh"]
