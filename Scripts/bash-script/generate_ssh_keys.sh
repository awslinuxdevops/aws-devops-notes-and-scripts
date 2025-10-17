#!/bin/bash

# SSH directory and config file
ssh_dir="$HOME/.ssh"
github_host="github.com"
config_file="$ssh_dir/config"

# Backup existing config if present
if [ -f "$config_file" ]; then
    backup_path="$config_file.backup.$(date +%F-%T)"
    cp "$config_file" "$backup_path"
    echo " Backup of existing config created at $backup_path"
fi

# Ask how many accounts to configure
read -p "How many GitHub accounts do you want to configure? " account_count

for ((i = 1; i <= account_count; i++)); do
    echo ""
    read -p "[$i] Enter Host alias (e.g., github-api_membership): " host_alias
    read -p "[$i] Enter key file name (e.g., api-diagnostics.mryoda.com): " key_name

    key_path="$ssh_dir/$key_name"

    # Generate SSH key if it does not exist
    if [ ! -f "$key_path" ]; then
        ssh-keygen -t rsa -b 4096 -C "$host_alias" -f "$key_path" -N ""
        echo " SSH key generated at $key_path"
    else
        echo " SSH key $key_path already exists. Skipping generation."
    fi

    # Check if the host_alias already exists in config
    if grep -q "Host $host_alias" "$config_file"; then
        echo " SSH config for $host_alias already exists. Skipping."
    else
        # Append new config
        {
            echo ""
            echo "Host $host_alias"
            echo "    HostName $github_host"
            echo "    User git"
            echo "    IdentityFile $key_path"
            echo "    IdentitiesOnly yes"
        } >> "$config_file"
        echo " SSH config entry added for $host_alias"
    fi
done

chmod 600 "$config_file"
echo -e "\nAll steps completed successfully!"
