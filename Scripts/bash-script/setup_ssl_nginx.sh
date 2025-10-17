#!/bin/bash
set -e

echo " Do you want to install packages (nginx, certbot, etc)?"
read -p "Type 'yes' to install, or 'no' to skip: " INSTALL_CHOICE

if [[ "$INSTALL_CHOICE" == "yes" ]]; then
    echo " Installing required packages..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y git nginx curl unzip ufw certbot python3-certbot-nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx
else
    echo " Skipping installation. Continuing with domain config only..."
fi

read -p " How many domains do you want to configure SSL for? " DOMAIN_COUNT

for ((i=1; i<=DOMAIN_COUNT; i++)); do
    echo ""
    read -p " Enter domain name #$i (e.g., example.com): " DOMAIN
    CONFIG_FILE="/etc/nginx/sites-available/$DOMAIN"

    if [[ -f "$CONFIG_FILE" ]]; then
        echo " Nginx config for $DOMAIN already exists. Skipping creation."
    else
        echo " Creating Nginx config for $DOMAIN..."
        sudo bash -c "cat > $CONFIG_FILE" <<EOL
server {
    listen 80;
    server_name $DOMAIN;

    location / {
        proxy_pass http://127.0.0.1:3000;  # Customize if needed
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOL
        sudo ln -sf "$CONFIG_FILE" /etc/nginx/sites-enabled/
    fi

    echo " Testing Nginx config..."
    sudo nginx -t && sudo systemctl reload nginx

    echo " Running Certbot for $DOMAIN..."
    sudo certbot --nginx -d "$DOMAIN"
done

echo -e "\n All domains processed. SSL setup complete!"
