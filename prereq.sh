sudo apt-get -y update
sudo apt-get -y install apache2 apache2-utils python3-pip python
sudo systemctl enable apache2
sudo systemctl start apache2
sudo pip3 install aws-cli --upgrade --user
sudo apt-get -y install php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php7.0-gd
sudo wget -c http://wordpress.org/latest.tar.gz -P /tmp/
sudo mkdir /tmp/wordpress
sudo tar -zxf /tmp/latest.tar.gz -C /tmp/wordpress
sudo mv /tmp/wordpress/wordpress/* /var/www/html/
echo "Changing Permissions and Owner"
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
echo "Getting RDS Hostname"
rdsHostname=`sudo aws rds describe-db-instances --db-instance-identifier wp-instance | python -c 'import json,sys;obj=json.load(sys.stdin);dbInstanceObj= obj["DBInstances"][0];print dbInstanceObj["Endpoint"]["Address"]'`
sudo sed -i  "s/localhost/$rdsHostname/g" /var/www/html/wp-config-sample.php
sudo sed -i "s/database_name_here/wp-instance/g" /var/www/html/wp-config-sample.php
sudo sed -i "s/username_here/root/g" /var/www/html/wp-config-sample.php
sudo sed -i "s/password_here/root/g" /var/www/html/wp-config-sample.php
