#!/bin/bash

set -e  # Exit on error

# Update and install necessary packages
sudo apt-get update
sudo apt-get install -y bind9 openvpn isc-dhcp-server ntp iptables-persistent easy-rsa

# Configure DNS (BIND9)
cat <<EOL | sudo tee /etc/bind/named.conf.local
zone "company.local" {
    type master;
    file "/etc/bind/db.company.local";
};

zone "2.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.168.1";
};

zone "2.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.168.2";
};
EOL

cat <<EOL | sudo tee /etc/bind/db.company.local
\$TTL    604800
@       IN      SOA     ns1.company.local. admin.company.local. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.
ns1     IN      A       192.168.1.2
EOL

cat <<EOL | sudo tee /etc/bind/db.192.168.1
\$TTL    604800
@       IN      SOA     ns1.company.local. admin.company.local. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.
1      IN      PTR     ns1.company.local.
EOL

cat <<EOL | sudo tee /etc/bind/db.192.168.2
\$TTL    604800
@       IN      SOA     ns1.company.local. admin.company.local. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.
3      IN      PTR     client.company.local.
EOL

sudo systemctl restart bind9

# Configure DHCP (isc-dhcp-server)
cat <<EOL | sudo tee /etc/dhcp/dhcpd.conf
subnet 192.168.1.0 netmask 255.255.255.0 {
  range 192.168.1.100 192.168.1.200;
  option routers 192.168.1.1;
  option domain-name-servers 192.168.1.1;
  option domain-name "company.local";
}

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
mkdir -p ~/openvpn-ca
cd ~/openvpn-ca
sudo cp -r /usr/share/easy-rsa/* ./
export EASYRSA_BATCH=1
export EASYRSA_REQ_CN="OpenVPN CA"
./easyrsa init-pki
./easyrsa build-ca nopass
./easyrsa build-server-full server nopass
./easyrsa gen-dh
openvpn --genkey --secret ta.key

# Copy certificates and keys to /etc/openvpn
sudo cp pki/ca.crt pki/private/server.key pki/issued/server.crt pki/dh.pem ta.key /etc/openvpn/

# Create server.conf
cat <<EOL | sudo tee /etc/openvpn/server.conf
#port 1194
proto udp
dev tun
ca /etc/openvpn/ca.crt
cert /etc/openvpn/server.crt
key /etc/openvpn/server.key
dh /etc/openvpn/dh.pem
server 10.10.0.0 255.255.255.0
ifconfig-pool-persist /etc/openvpn/ipp.txt
push "route 192.168.1.0 255.255.255.0"
keepalive 10 120
tls-auth /etc/openvpn/ta.key 0
cipher AES-256-CBC
comp-lzo
persist-key
persist-tun
status /var/log/openvpn-status.log
verb 3 

# Specify the port and protocol
port 1194
proto udp
dev tun

# Specify the paths to your certificate files
ca /usr/share/easy-rsa/ca.crt
cert /usr/share/easy-rsa/server.crt
key /usr/share/easy-rsa/server.key
dh /usr/share/easy-rsa/dh2048.pem

# Specify the VPN subnet
server 10.8.0.0 255.255.255.0

# Enable IP forwarding
push "redirect-gateway def1"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"

# Define how OpenVPN should handle clients
keepalive 10 120
comp-lzo
persist-key
persist-tun

# Define log files
status /run/openvpn/server.status
log-append /var/log/openvpn.log
verb 3

# Enable management interface (optional, for debugging)
# management 127.0.0.1 7505

EOL

sudo systemctl start openvpn@server
sudo systemctl enable openvpn@server

# Configure Firewall (iptables)
sudo iptables -A INPUT -i eth1 -p udp --dport 1194 -j ACCEPT
sudo iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -s 10.10.0.0/24 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s 10.10.0.0/24 -o eth0 -j MASQUERADE

sudo netfilter-persistent save
sudo netfilter-persistent reload
