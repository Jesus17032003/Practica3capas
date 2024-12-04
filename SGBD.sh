apt install mysql-server -y
apt update -y
apt install -y mysql-server
sed -i "s/^bind-address\s*=.*/bind-address = 192.168.10.157/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

mysql <<EOF
CREATE DATABASE db_wordpress;
CREATE USER 'JesusA'@'192.168.10.%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON db_wordpress.* TO 'JesusA'@'192.168.10.%';
FLUSH PRIVILEGES;
EOF