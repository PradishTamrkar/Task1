#!/bin/bash

# Installing mysql
sudo apt update
sudo apt install -y mysql-server

# Setting up mysql database
sudo mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS wpuser@'%' IDENTIFIED BY 'admin12345';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER ON wordpress.* TO wpuser@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Allowing remote connection
sudo sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
