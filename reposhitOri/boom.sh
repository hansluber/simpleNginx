#!/bin/bash

echo "============================="
echo "Installing Nginx"
echo "============================="
#Install Nginx
sudo apt -y install nginx
echo "============================="
echo "Nginx Already Installed"
echo "============================="
echo "Creating Nginx Config File"
echo "============================="
#Create Nginx Config File
sudo touch /etc/nginx/sites-available/mukabuku
sudo tee /etc/nginx/sites-available/mukabuku <<EOF
server {
        listen 80;
        root /var/www/html/mukabuku;
        # Add index.php to the list if you are using PHP
        index index.php index.html index.htm index.nginx-debian.html;
        server_name 18.136.141.59;
        #bisa diganti dengan ip address localhostmu atau ip servermu, nanti kalau sudah ada domain diganti nama domainmu. 
        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files / =404;
        }
        location ~ \.php$ {
          include snippets/fastcgi-php.conf;
          fastcgi_pass unix:/run/php/php7.2-fpm.sock;
        }
}
EOF
#Test Nginx Confiugration
sudo nginx -t
#Restart Nginx Web Server
sudo systemctl restart nginx
echo "============================="
echo "Installing php-fpm & php-mysql Dependencies"
sudo apt install php-fpm php-mysql
echo "============================="
echo "Dependencies Already Installed"
echo "============================="
#Creating the Symlink of Nginx Config File
sudo ln -s /etc/nginx/sites-available/mukabuku /etc/nginx/sites-enabled/mukabuku
#Creating Directory of the App File
sudo mkdir /var/www/html/mukabuku && cd /var/www/html/mukabuku && sudo wget https://github.com/sdcilsy/sosial-media/archive/master.zip && sudo unzip master.zip
#Move the App File into Destination Path
sudo mv /var/www/html/mukabuku/sosial-media-master/* /var/www/html/mukabuku/
echo "============================="
echo "Web App Ready to Launch"
echo "============================="
