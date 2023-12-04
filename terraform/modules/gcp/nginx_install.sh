#!/bin/bash
set -e
echo "*****    Installing Nginx    *****"
apt update
apt install -y nginx
ufw allow '${ufw_allow_nginx}'
systemctl enable nginx
systemctl restart nginx

echo "*****   Installation Complteted!!   *****"

touch /var/www/html/index.html
rm -f /var/www/html/index.nginx-debian.html
echo "

<!DOCTYPE html>
<html>
<html>
   <body>
      <head>
         <title>Terraform Webserver</title>
      </head>
      <p>Add your details:</p>
      <form>
         Student Name:<br> <input type=text name=name>
         <br>      
      </form>
   </body>
</html>

" > /var/www/html/index.html

echo "*****   Startup script completes!!    *****"