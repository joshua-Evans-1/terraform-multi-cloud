#!/bin/bash
# further implementation of nginx webserver
apt update
apt install -y nginx
ufw allow '${ufw_allow_nginx}'

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<html>
   <body>
      <head>
         <title>Terraform Webserver</title>
      </head>
      <p>Add your name:</p>
      <form>
         Student Name:<br> <input type=text name=name>
         <br>      
      </form>
      <p>Database response:</p>
   </body>
</html>
EOF

systemctl enable nginx
systemctl restart nginx
