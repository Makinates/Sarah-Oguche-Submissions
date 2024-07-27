#!/bin/bash

# Update and install necessary packages
sudo apt-get update
sudo apt-get install -y openvpn

# Copy VPN configuration files
sudo cp /vagrant/vpn-config/* /etc/openvpn/

# Create client.conf
cat <<EOL | sudo tee /etc/openvpn/client.conf
client
dev tun
proto udp
remote 192.168.1.1 1194
resolv-retry infinite
nobind
persist-key
persist-tun
ca /etc/openvpn/ca.crt
cert /etc/openvpn/client1.crt
key /etc/openvpn/client1.key
tls-auth /etc/openvpn/ta.key 1
cipher AES-256-CBC
comp-lzo
verb 3
EOL

# Start OpenVPN client service
sudo systemctl start openvpn@client
sudo systemctl enable openvpn@client
