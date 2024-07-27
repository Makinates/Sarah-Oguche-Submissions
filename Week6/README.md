                                                  Network Administration 2


**Netwrork Diagram**

![image](https://github.com/user-attachments/assets/2d24aba0-0c19-4bc0-8b16-bb6191d7eb4e)

**Environment Setup**

The first steps to implementing the tasks is to download the virtual box and install on the computer.
The next step is to download and install vagrant.

1.	Create the Project Directory on my computer.
I used my existing repo and created my directory from the existing location.
mkdir network-setup
cd network-setup
mkdir main-office branch-office client

2.	Create Vagrantfile:
I created my Vagrantfile in my network-setup directory

![image](https://github.com/user-attachments/assets/8322ddae-a71b-4fa4-b29b-da52ed57140c)

Create Provision Scripts

1.	Create the main-office/provision.sh file
 
![image](https://github.com/user-attachments/assets/b0e86ec2-e0dc-4003-9e0f-97849d4dfade)

2.	Create the branch-office /provision.sh file

![image](https://github.com/user-attachments/assets/838c5451-0acd-4ffb-9417-37b689a44bba)
 
3.	Create the client /provision.sh file

![image](https://github.com/user-attachments/assets/c1125293-833a-4823-a6c8-bea4c62bc5fb)

After creating the files, the next step is to bring up the Virtual machines
vagrant up
I got the message below indicating that one of the IPs is in use already so I have to modify my config files. However, the main-office VM was created already as I can see it in my Virtual box.
  
![image](https://github.com/user-attachments/assets/7d105800-f9ed-4e5c-b42d-66855fed8385)

![image](https://github.com/user-attachments/assets/e909a545-f274-4186-b9fe-e4496977a92e)

After modifying my vagrant file and the three provision files, I proceeded to run the “vagrant up” command.
The main office virtual machine has been created and is running but other VMs have not been created yet and the process is taking to long.

![image](https://github.com/user-attachments/assets/923ca2cb-55bf-4225-97e3-eb37f3c49145)


Main office VM created

![image](https://github.com/user-attachments/assets/3f836f55-4440-48f0-b6a8-d6fa8892dd43)

![image](https://github.com/user-attachments/assets/75b131e3-88f0-4d9e-a320-53c84b8e5927)

 
Branch office VM created

![image](https://github.com/user-attachments/assets/a63d8321-5cbc-478f-a4de-ba76de55b3cd)

![image](https://github.com/user-attachments/assets/39b1aa36-2e3e-4d7e-8b4f-ac94b340c283)

 
Client VM created

![image](https://github.com/user-attachments/assets/d3e7d17f-ccf2-4bc2-950a-58d7cd579d17)

![image](https://github.com/user-attachments/assets/0a07cf17-1b4c-4f11-a526-b6cc01d193d7)


The virtual box manager displays all virtual machines and a summary of their status

![image](https://github.com/user-attachments/assets/7b9c2acb-f64a-467d-b777-abebd8933f81)


After the successful environment setup covering security and network we need to verify that the NTP, DNS, DHCP and VPN set up are working on all servers.

Main Office

![image](https://github.com/user-attachments/assets/61c40d12-e919-4a47-8948-d053c3f77e64)

![image](https://github.com/user-attachments/assets/cfaacbe3-3435-4f4d-a94e-f921bdf3c81c)

![image](https://github.com/user-attachments/assets/0dd17cb5-0d3d-4c14-bb15-20f6407c26e7)

![image](https://github.com/user-attachments/assets/b7f654cc-3efb-4386-aff1-ace2831ca8c8)

![image](https://github.com/user-attachments/assets/da77a2b3-10ac-4dd9-b081-e20d08ea275f)

![image](https://github.com/user-attachments/assets/7027367c-7b17-4621-b743-2da562098662)


Client
The client was able to reach the Main office server successfully.
VPN was also set up successfully.

![image](https://github.com/user-attachments/assets/b607211d-863a-45c2-8da2-7c724f898911)

![image](https://github.com/user-attachments/assets/97003886-6970-4c18-be59-0ebd03d67b4c)


Branch

![image](https://github.com/user-attachments/assets/38451e40-8689-45d7-905b-f4619ff31058)

![image](https://github.com/user-attachments/assets/a63f0ace-e8fb-48a0-8942-62571c3ac472)

**Network Analysis and Troubleshooting**

1.	Perform Network Scanning
Install nmap on both the Main Office and Branch Office servers if not already installed:
sudo apt-get update
sudo apt-get install nmap

Main

![image](https://github.com/user-attachments/assets/653fdd8b-3499-40f0-9fc4-68625c2c90b7)

Branch VM

![image](https://github.com/user-attachments/assets/40b91dbd-c260-4ab6-8a29-67eb4690ee7a)

![image](https://github.com/user-attachments/assets/94a8d4da-8b0a-4596-87f6-40846675ef78)

2. 	Scan the Main Office network from the Branch Office server to check for open ports and services:
sudo nmap -sP 192.168.2.2/24

![image](https://github.com/user-attachments/assets/602ce43a-0ba4-4510-a4cc-6ef8d07cef23)

3.	Scan the Branch Office network from the Main Office server:
sudo nmap -sP 192.168.1.2/24

![image](https://github.com/user-attachments/assets/859b52cc-934b-4e3c-b2b3-5c0ff562ad83)

![image](https://github.com/user-attachments/assets/b408e128-ae9c-4865-9421-d81a928c8930)

**Capture and Analyze Network Traffic**

1. Install tcpdump on the Main and Branch VMs
sudo apt-get install tcpdump

Main 

![image](https://github.com/user-attachments/assets/ca837546-4f25-4c7e-936b-62d5fee988f2)

Branch

![image](https://github.com/user-attachments/assets/b0fd97f0-ceff-4596-8a50-d16bad3463ed)

2. Capture traffic on the Main Office and Branch Office servers
sudo tcpdump -i eth0 -w main-office.pcap
sudo tcpdump -i eth0 -w branch-office.pcap

4. Analyze captured traffic using Wireshark:
   
•  Transfer the .pcap files to a local machine where Wireshark is installed.
•  Open the files in Wireshark to inspect network packets, verify VPN traffic, and troubleshoot any issues.

**Automation**

Develop Ansible Playbooks

DHCP Configuration

![image](https://github.com/user-attachments/assets/a1a8af07-a944-48f5-a768-dbe6ce97b165)

Dhcpd.conf

![image](https://github.com/user-attachments/assets/6a53a17b-17f3-4519-9906-71c1f77921d2)

DNS Configuration

![image](https://github.com/user-attachments/assets/2f275f9d-a2db-429f-9abf-e461d9fa4f94)

named.conf.local

![image](https://github.com/user-attachments/assets/d6e20a60-b6df-4b34-b01d-e6f3fa80f2e9)

NTP Configuration

![image](https://github.com/user-attachments/assets/52c8bb23-462c-46c8-9501-7dac84d8091a)

ntp.conf

![image](https://github.com/user-attachments/assets/ded26d4f-f682-4076-9b73-aef82fb1ccb4)

Firewall Configuration

![image](https://github.com/user-attachments/assets/b008d660-9112-4dc3-b1cc-ad354c90355e)

The playbooks can be run using the following commands:
ansible-playbook -i inventory dhcp.yml
ansible-playbook -i inventory dns.yml
ansible-playbook -i inventory ntp.yml
ansible-playbook -i inventory firewall.yml

![image](https://github.com/user-attachments/assets/f271046c-8825-41b6-9e43-bbde2b5c9495)

**Terraform to provision a cloud VM simulating an additional branch office**

![image](https://github.com/user-attachments/assets/fc5076fc-81b9-439d-b5dc-66053f3331f1)







