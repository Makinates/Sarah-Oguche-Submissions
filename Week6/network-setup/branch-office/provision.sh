#!/bin/bash

# Update and install necessary packages
sudo apt-get update
sudo apt-get install -y bind9 openvpn isc-dhcp-server ntp iptables-persistent

# Configure DNS (BIND9)
cat <<EOL | sudo tee /etc/bind/named.conf.local
zone "company.local" {
    type slave;
    masters { 192.168.1.1; };
    file "/var/cache/bind/db.company.local";
};
EOL

sudo systemctl restart bind9

# Configure DHCP (isc-dhcp-server)
cat <<EOL | sudo tee /etc/dhcp/dhcpd.conf
subnet 192.168.2.0 netmask 255.255.255.0 {
  range 192.168.2.100 192.168.2.200;
  option routers 192.168.2.1;
  option domain-name-servers 192.168.2.1;
  option domain-name "company.local";
}
EOL

sudo systemctl restart isc-dhcp-server

# Configure NTP
cat <<EOL | sudo tee /etc/ntp.conf
driftfile /var/lib/ntp/ntp.drift
server 0.ubuntu.pool.ntp.org iburst
server 1.ubuntu.pool.ntp.org iburst
server 2.ubuntu.pool.ntp.org iburst
server 3.ubuntu.pool.ntp.org iburst
EOL

sudo systemctl restart ntp

# Configure VPN (OpenVPN)
sudo apt-get install -y openvpn easy-rsa
make-cadir ~/openvpn-ca
cd ~/openvpn-ca
source vars
./build-key client1
cd keys

# Create client1.conf
cat <<EOL | sudo tee /etc/openvpn/client1.conf
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

# Copy VPN client files to shared location for client VM
sudo mkdir -p /vagrant/vpn-config
sudo cp ca.crt client1.crt client1.key ta.key /vagrant/vpn-config/

sudo systemctl start openvpn@client1
sudo systemctl enable openvpn@client1

# Configure Firewall (iptables)
sudo iptables -A INPUT -i eth1 -p udp --dport 1194 -j ACCEPT
sudo iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -s 192.168.
