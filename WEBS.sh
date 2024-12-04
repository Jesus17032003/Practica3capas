apt update -y
apt install apache2 -y
apt install nfs-common -y
apt install php libapache2-mod-php php-mysql php-curl php-gd php-xml php-mbstring php-xmlrpc php-zip php-soap php -y
a2enmod rewrite
#servidores web
sudo sed -i 's|DocumentRoot .*|DocumentRoot /nfs/shared/wordpress|g' /etc/apache2/sites-available/000-default.conf

sed -i '/<\/VirtualHost>/i \
<Directory /nfs/shared/wordpress>\
    Options Indexes FollowSymLinks\
    AllowOverride All\
    Require all granted\
</Directory>' /etc/apache2/sites-available/000-default.conf


cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/websv.conf
# Montar la carpeta compartida desde el servidor NFS

mkdir -p /nfs/shared
mount 192.168.10.138:/var/nfs/shared /nfs/shared
a2dissite 000-default.conf
a2ensite websv.conf
systemctl restart apache2
systemctl reload apache2
systemctl status apache2