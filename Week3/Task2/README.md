**Create and manage AWS resources (e.g., EC2 instances, VPCs, security groups, S3 buckets) using the AWS CLI. Screenshots of the CLI outputs and corresponding screenshots of the provisioned resources in the AWS Management Console must be provided in your documentation.**

The prerequisites:

•  AWS CLI installed and configured with appropriate permissions.
•  AWS account with access to the resources you want to manage.

To be able to use the AWS CLI

After launching your terminal, you need to run the aws configure command to set up your environment/workspace if not already done.

The first step is to install AWS CLI and then configure the interface.

When running the command “aws configure” for the first time, you will need to enter the access key, access secret, AWS region and the file format of the AWS output.

After setting these up correctly and saving them, you start to work from the AWS CLI after running the command.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/57dc3082-c018-4ba7-b876-ec6b3a3b7317">

Creating an S3 Bucket:

To create an S3 bucket, run the command below on the AWS CLI console

aws s3 mb s3://sarah-bucket2

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/7c9736fd-26ac-43a0-bf72-d99b9d693789">

I can confirm from the AWS management console that the bucket has been created.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/e8a9b3cb-ee13-457a-8a47-21e4801a2dbd">

Creating a VPC:

A VPC can be created by running the command below:

After the VPC has been created, we can then name the VPC using the ID of the newly created VPC.

aws ec2 create-vpc --cidr-block 10.0.0.0/16

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/0a686c69-174b-472f-98c9-38a2c317c935">

To add a name tag to the VPC, we run the command:

aws ec2 create-tags --resources vpc-00db365d4bf6b5526 --tags Key=Name,Value=MyVPC1

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/8a2c7e01-4d7d-479d-b8e4-063a9cb3f156">

Creating a Security Group:

aws ec2 create-security-group --group-name sarah-security-group --description "My security group" --vpc-id vpc-00db365d4bf6b5526

We replace the –group.name with the name of the Security group , add a description and the vpc id with the VPC of choice

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/3251bb3f-0cac-4290-ac7b-c5cd23734957">


<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/37ad0f2f-813c-41cc-8adf-7d30bd6a7e7b">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/29f4afb8-48e0-4764-9109-a6e26da5cfb8">

We can then set Inbound and outbound rules for the security group

Inbound rules to Allow SSH access (port 22) from any IP:

aws ec2 authorize-security-group-ingress --group-id sg-0dc86e15aab7e5dc9 --protocol tcp --port 22 --cidr 0.0.0.0/0

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/1d3dce74-d120-4728-abe4-09717e9823ae">

Inbound rules to Allow HTTP access (port 80) from any IP:

aws ec2 authorize-security-group-ingress --group-id sg-0dc86e15aab7e5dc9 --protocol tcp --port 80 --cidr 0.0.0.0/0

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/ae4743d4-51df-4574-aa7f-ebcb4405c92a">

Inbound rules to Allow HTTPS access (port 443) from any IP:

aws ec2 authorize-security-group-ingress --group-id sg-0dc86e15aab7e5dc9 --protocol tcp --port 443 --cidr 0.0.0.0/0

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/4c6b0398-75fc-42a5-8c81-b938cfff33f8">

Outbound rules: We will allow all outbound traffic which is usually the default setting.

aws ec2 authorize-security-group-egress --group-id sg-0dc86e15aab7e5dc9 --protocol -1 --port all --cidr 0.0.0.0/0

This command will most likely throw an error that the permission already exists because it is the default as earlier mentioned.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/8f120dee-f919-48a7-a024-855d706e64af">

From the management console, all 3 outbound rules have been added to the security group

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/bc0348bd-4d95-4261-b442-6f39c5fcdf8d">

Creating a Key Pair

aws ec2 create-key-pair --key-name sarah-key-pair --query 'KeyMaterial' --output text > my-key-pair.pem

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/98e65428-ad9b-4e82-9667-2f62315f2ca1">

Creating a Subnet

aws ec2 create-subnet --vpc-id vpc-00db365d4bf6b5526 --cidr-block 10.0.1.0/24 --availability-zone us-east-1a

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/c8caa5dd-9120-4e41-a286-6cd63798d1fd">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/972a0087-f0a1-4388-95f4-664d6f7eccbf">

Launching the EC2 Instance:

The ubuntu EC2 instance can be launched from the AWS CLI using the command below

aws ec2 run-instances --image-id ami-xxxxxxxx --count 1 --instance-type t2.micro --key-name my-key-pair --security-group-ids sg-0dc86e15aab7e5dc9 --subnet-id subnet-xxxxxxxx

Subnet id: subnet-021ea270573399f8a

For this instance, I will be using an AMI from qucikstart AMIs

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/d87ce842-b3f0-4779-a25c-1befb9a89e1f">

AMI ID: 01e076d5c9e040974

Alternatively, I can use the CLI to search for AMIs

aws ec2 describe-images --owners 099720109477 --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-*-20.04-amd64-server-*" --query "Images[*].[ImageId,Name]" --output text

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/03a8ca3d-cc63-437b-98f7-1e6032433619">

The instance will then be launched with this script:

aws ec2 run-instances --image-id ami-01e076d5c9e040974 --count 1 --instance-type t2.micro --key-name sarahkeypair2 --security-group-ids sg-0dc86e15aab7e5dc9 --subnet-id subnet-021ea270573399f8a

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/e223b2e0-749b-443b-83b7-145e76f4be02">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/c0f3ca10-9812-4003-89d4-84a17e4b3b82">


To connect to my instance: 

The username for a linux instance – ubuntu instance is ubuntu as in the command below:

ssh -i /Users/hp/downloads/sarahkeypair2.pem ubuntu@52.203.145.191

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/2b1367ce-9768-4b27-a3ef-9e4a5f435f50">

To update te packages on the instance:

sudo apt update

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/5b75a9d0-b44e-4cfb-beed-5222a0008959">



Deploy and configure a web application or service on AWS using EC2 instances

The packages have already been installed and updated.

Install Apache for Ubuntu

sudo apt install apache2

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/9d2b2c50-8fde-453a-99ee-29c5f70d1581">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/efdd8590-936e-49de-8db4-f5aec068b757">

Start Apache service:

sudo systemctl start apache2

Enable the Apache service to start on boot:

sudo systemctl enable apache2

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/759b088f-721d-4095-a4c6-7b23a9df523f">

Deploy the web application.

I will be deploying a "Hello, World!" HTML Page

Create the HTML File:

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/98cc94ac-6dc7-44d7-8509-429aaf9acec2">

Transfer the file to the EC2 instance

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/0810a09c-4ba1-4f0b-8106-a10f9830f2b5">

After transferring the file to the instance, I need to confirm that the file has been moved to the instance,

cd /tmp

ls -l hello.html


<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/2cd653dd-8ade-4ff1-88b7-5cff42bf8d75">

The next step is to move the Hello.html file from tmp to Apache's document root directory:

sudo mv /tmp/hello.html /var/www/html/

The next step is to launch the application on my browser.

http://52.203.145.191/hello.html

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/2d81a2e4-e1ea-441b-97f2-70fe9b2bb3e9">




















