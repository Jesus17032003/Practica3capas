#provisionamiento del nfs
apt update -y
apt install nfs-kernel-server -y
apt install unzip -y
apt install curl -y
apt install php php-mysql -y
apt install mysql-client -y

mkdir /var/nfs/shared -p
chown nobody:nogroup /var/nfs/shared
sed -i '$a /var/nfs/shared    192.168.10.140/24(rw,sync,no_subtree_check)' /etc/exports
sed -i '$a /var/nfs/shared    192.168.10.133/24(rw,sync,no_subtree_check)' /etc/exports
curl -O https://wordpress.org/latest.zip
unzip -o latest.zip -d /var/nfs/shared/
chmod 755 -R /var/nfs/shared/
chown -R www-data:www-data /var/nfs/shared/*
chown -R nobody:nogroup /var/nfs/shared/
systemctl restart nfs-kernel-server