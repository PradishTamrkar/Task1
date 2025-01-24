#!/bin/bash

# Installing dependencies for MySQL and Apache
sudo apt update
sudo apt install -y apache2 ghostscript libapache2-mod-php mysql-server php php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-mysql php-xml php-zip

# Installing WordPress
sudo mkdir -p /srv/www
sudo chown -R www-data:www-data /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www

# Apache2 configuration
sudo bash -c "cat > /etc/apache2/sites-available/wordpress.conf" <<EOL
<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress
    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride All
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>
EOL

sudo a2ensite wordpress
sudo a2enmod rewrite
sudo a2dissite 000-default

# Restarting Apache2
sudo systemctl restart apache2

# Checking Apache2 status
sudo systemctl status apache2


