#!/bin/bash

# Start the SSH agent
eval $(ssh-agent -s)

# Function to add SSH keys from the config file
add_keys_from_config() {
    while IFS= read -r line; do
        if [[ $line == IdentityFile* ]]; then
            key=$(echo $line | awk '{print $2}')
            ssh-add $key
        fi
    done < /root/.ssh/config
}

# Check if the config file exists and add keys from it
if [ -f /root/.ssh/config ]; then
    add_keys_from_config
else
    # If no config file, add default keys
    for key in /root/.ssh/id_rsa /root/.ssh/id_dsa /root/.ssh/id_ecdsa /root/.ssh/id_ed25519; do
        if [ -f $key ]; then
            ssh-add $key
        fi
    done
fi

# Start code-server
code-server --bind-addr 0.0.0.0:8090 --auth none