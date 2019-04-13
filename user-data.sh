apt-get update
apt-get install apache2 apache2-utils
systemctl enable apache2
systemctl start apache2
apt-get install php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php7.0-gd
echo '<?php phpinfo(); ?>' >> /var/www/html/info.php 
wget -c http://wordpress.org/latest.tar.gz -o /home/tmp
rsync -av /home/tmp/wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/
