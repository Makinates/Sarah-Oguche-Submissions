                                                            Network Administration 2
Environment Setup
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











