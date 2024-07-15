                                                                          LINUX ADMINISTRATION 2
Task 1: User and Group Management

1.	Create a new user for the web application:

sudo dscl . -create /Users/webuser

sudo dscl . -create /Users/webuser UserShell /bin/bash

sudo dscl . -create /Users/webuser UniqueID 1001  # Replace with a unique ID

sudo dscl . -create /Users/webuser PrimaryGroupID 1001  # Replace with a unique group ID

sudo dscl . -create /Users/webuser RealName "Web Application User"

sudo dscl . -create /Users/webuser Password "*"  # Set password

sudo dscl . -append /Groups/webgroup GroupMembership webuser


2.	Create a new group for web-related processes:

sudo dseditgroup -o create webgroup

3.	Add the new user to the web group:

sudo dseditgroup -o edit -a webuser -t user webgroup

<img width="468" alt="image" src="https://github.com/user-attachments/assets/1f41d620-2af0-4fe6-bf2b-9c1a83cd37ac">

Task 2: File System Management

1.	Create a new partition for web data:

I created a new volume in dev/disk3

Instead of creating a partition on my MAC, I created a volume. 

However, creating a volume instead of a partition auto creates a filesystem

sudo diskutil apfs addVolume disk3 APFS webdata

<img width="468" alt="image" src="https://github.com/user-attachments/assets/ab248588-2a37-4a8d-a30c-432ddd992484">


<img width="468" alt="image" src="https://github.com/user-attachments/assets/a41f5859-9ee3-475d-b8a9-cb66a457000e">

<img width="468" alt="image" src="https://github.com/user-attachments/assets/92ebc23c-66f8-4865-9a5d-e665e490028a">

<img width="468" alt="image" src="https://github.com/user-attachments/assets/330833a7-5cc2-48a7-a09a-24bff1bf1334">

2.	Create a mount point and mount the new volume:

I got the error below when trying to create a mount point.

<img width="468" alt="image" src="https://github.com/user-attachments/assets/418bd9a1-4596-422e-8244-0cdd3e3071ea">

To fix the error: I need to create the mount directory: sudo mkdir -p /mnt/webdata

I kept getting the error below when I tried to set ownership to the new volume so I did this to resolve the issue:

<img width="468" alt="image" src="https://github.com/user-attachments/assets/f38d611b-3fe9-43ad-be06-8e02d8bd0716">

To ensure that these system folders don’t interfere, it’s common to create a specific subdirectory for your web content, like /Volumes/WebData/www, and set ownership there instead:

<img width="468" alt="image" src="https://github.com/user-attachments/assets/1da88fb2-b050-45e2-b0ab-734ac5d9c6d0">

After successfully implementing, I need to confirm ownership of the directory

ls -l /Volumes/WebData

<img width="468" alt="image" src="https://github.com/user-attachments/assets/d191b60c-a301-44e7-866e-46475f44d137">

Task 3.	Servivce Management

Instal  the web server - Nginx

brew install nginx

<img width="468" alt="image" src="https://github.com/user-attachments/assets/535bcf5a-ac3b-484c-aba6-ffaba52c2a49">

The server is installed on the system by default. I need to ensure that the new web server serves files from my secified directory.

This will be done by updating the config file to read from my specified directory instead of root.

This command will open the config file

sudo nano /opt/homebrew/etc/nginx/nginx.conf

The modification is: root /Volumes/WebData/www;

Start the Service

Then I proceed to start the service

brew services start nginx

<img width="468" alt="image" src="https://github.com/user-attachments/assets/e564e4ff-7a1d-45a2-9e9e-c6741aba47af">

Enable Nginx on Boot: Nginx should automatically start on boot if installed via Homebrew.


Task 4.	Task Scheduling

Set up a daily backup of the web directory using cron

The first step is to edit the cron tab

crontab -e

Add a line to back up the www directory:

0 2 * * * tar -czf /path/to/backup/webdata-$(date +\%Y-\%m-\%d).tar.gz /Volumes/WebData/www

I tired using vim as the editor but I couldn’t run the cron

SO I will be setting nano as my default ediot

export VISUAL=nano; crontab -e

Then I enter my command for the backup

<img width="453" alt="image" src="https://github.com/user-attachments/assets/3ba3ecf9-0b64-46c1-870e-5aa32b71a005">

To verify that my cron tab has been added I will run this: crontab -l

<img width="468" alt="image" src="https://github.com/user-attachments/assets/7154cf07-1547-4c42-915c-03a85a8523b8">


Task 5.	Process Monitoring

Monitor Nginx Processes: Use ps and top to check if Nginx is running.

ps aux | grep nginx

top

The command will show all running processes on the system

<img width="468" alt="image" src="https://github.com/user-attachments/assets/8bb27460-eeab-4ad9-8510-b7db847194cb">

Task 6.	Security Considerations

Adjust Permissions: Ensure that the permissions on /Volumes/WebData/www are set correctly. To limit access:

sudo chmod -R 750 /Volumes/WebData/www

Task 7.	Testing and Verification

Verify Nginx is Running: Check the status of the Nginx service:

This command will not work as I installed Nginx using Homebrew

hp@MacBook-Air ~ % sudo systemctl status nginx

<img width="468" alt="image" src="https://github.com/user-attachments/assets/6b6eed1f-5899-4763-a956-dce9dca2cb84">

The correct command is: 

brew services list 

or 

sudo launchctl list | grep nginx

<img width="468" alt="image" src="https://github.com/user-attachments/assets/c8a0580d-fe21-475f-b6bd-5861a9e30518">

The server isn’t running. I will go ahead and start it 

brew services start nginx

I got an error, because the application was set up manually. 

<img width="468" alt="image" src="https://github.com/user-attachments/assets/947b0e1a-d6ae-4dbd-902f-b08d21ec8738">

It still did not work

<img width="468" alt="image" src="https://github.com/user-attachments/assets/7c23823f-226c-4f81-8c0c-9003d4520223">

The newt step is to check the logs which did not work either so I modified the permissions

<img width="468" alt="image" src="https://github.com/user-attachments/assets/060ffa43-c8a6-4b4c-80b9-73e65adcae1e">

I was still having issues starting the Nginx, so I checked the logs and modified the permisisons and deleted any pid file.
Step 1: Fix Permissions on Nginx Directories
sudo chown -R $(whoami) /opt/homebrew/var/log/nginx
sudo chown -R $(whoami) /opt/homebrew/var/run/nginx
sudo chmod -R 755 /opt/homebrew/var/log/nginx
sudo chmod -R 755 /opt/homebrew/var/run/nginx

Step 2: Remove Any Existing PID File
sudo rm -f /opt/homebrew/var/run/nginx/nginx.pid

Step 3: Attempt to Start Nginx
sudo brew services start nginx

<img width="468" alt="image" src="https://github.com/user-attachments/assets/f590420d-4611-4bdb-a0bd-1fe294961b74">

I restarted the service

<img width="468" alt="image" src="https://github.com/user-attachments/assets/009bb177-e47a-4e55-a6a7-7fc434a5eede">

When I checked the status of the services, it still shows that nginx is still not running

<img width="468" alt="image" src="https://github.com/user-attachments/assets/3aa2e663-b239-4dc3-87e5-f86eb48baf8c">

Nginx is running, but the master process is still running as root, which can cause permission issues with the PID file. Here's how to resolve this:

1. Stop Nginx

First, stop the currently running Nginx service:

brew services stop nginx

sudo pkill nginx

ps aux | grep nginx

<img width="468" alt="image" src="https://github.com/user-attachments/assets/a068e2a1-69d4-4b01-8f63-fa02ee4bc9a1">

2.	Change the Nginx Configuration

Edit your Nginx configuration file (/opt/homebrew/etc/nginx/nginx.conf) to specify the user under which Nginx should run. Add or modify the user directive at the top of the configuration file:

sudo nano /opt/homebrew/etc/nginx/nginx.conf

user hp;

3.	Change Ownership and Permissions

Ensure the PID directory and any necessary directories are correctly owned by my user:

sudo chown -R $(whoami) /opt/homebrew/var/run/nginx

sudo chown -R $(whoami) /opt/homebrew/var/log/nginx

4.	Edit LaunchAgent Plist

Edit the ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist to make sure it does not try to run as root. Open the file in your preferred text editor:

nano ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist

I pasted this: 

<img width="468" alt="image" src="https://github.com/user-attachments/assets/2b4f148c-28f5-4d46-b5c7-0379b0533b61">

5.	Load the LaunchAgent as My User: hp

Reload the LaunchAgent as your user:

launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist

6.	Start Nginx Again

brew services start nginx

7.	Check Status

brew services list

<img width="468" alt="image" src="https://github.com/user-attachments/assets/f000ecea-39dd-4c05-8131-0c2fff7534a3">

8.	Test the Nginx Config

<img width="468" alt="image" src="https://github.com/user-attachments/assets/9210d8df-50bc-48ad-a835-e5afb60e448a">

Test the web server by accessing it from a browser or using curl

<img width="468" alt="image" src="https://github.com/user-attachments/assets/fe97845e-393a-4370-bb7b-ba3aedc8d1d8">

<img width="468" alt="image" src="https://github.com/user-attachments/assets/ea3c8dfc-434c-479b-a383-e99927d48e4a">

























