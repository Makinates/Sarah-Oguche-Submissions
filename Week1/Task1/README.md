                                                                     Network Fundamentals


To configure virtual machines or cloud instances with different network configurations (e.g subnets, VPCs, security groups and network access control lists) AWS the following prerequisites must be in place.

Terraform must be installed on your computer.
An AWS account must be set up.
In this case, we will use AWS CLI to implement the actions.
Link to install terraform [Terraform](https://developer.hashicorp.com/terraform/install)
Link to download AWS CLI https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

The steps for implementation are:
Step 1: Define Your Provider and Initialize Terraform
Step 2: Create a VPC
Step 3: Create Subnets
Step 4: Create an Internet Gateway
Step 5: Create Route Tables
Step 6: Create Security Groups
Step 7: Create EC2 Instance
Step 8: Apply the Terraform Configuration
Step 9: Test Network Connectivity
1.	SSH into the Public Instance
2.	Ping the Private Instance
3.	Telnet

After creating the separate .tf files, the next step is to initialize terraform by running the code below
terraform init
![image](https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/64c6130c-fe3d-4a04-9453-e386e6882f7c)

To be able to successfully run the configuration, I need to configure Terraforn to use AWS CLI. This can be done on the same CLI window.
 Verify AWS Credentials: Ensure that you have valid AWS Access Key ID and Secret Access Key.
Set Up AWS CLI: Configure the AWS CLI to make sure your credentials are working correctly. Run the following command in your terminal:

![image](https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/9f962884-9155-42af-9b46-0f91444d9720)

To use the AWS CLI console, access keys need to be created for the user account.
Creating Access Keys
To create a new access key for an IAM user:
1.	Sign in to the AWS Management Console: Go to the AWS Management Console.
2.	Navigate to the IAM Console: In the services menu, search for and select IAM.
3.	Select Users: In the IAM dashboard, select Users from the navigation pane.
4.	Choose the User: Click on the IAM user for which you want to create an access key.
5.	Security Credentials Tab: Go to the Security credentials tab.
6.	Create Access Key: Scroll down to the Access keys section and click Create access key. Follow the prompts to create a new access key.
7.	Download the Credentials: Download the credentials file or copy the Access Key ID and Secret Access Key to a secure location. You will not be able to see the Secret Access Key again after this step, so make sure to save it securely.

![image](https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/8af5fd66-399d-459e-b55b-c79e2ab4d15b)

After successfully applying the terraform configuration, the instance will be created.
A summary of the configuration will be displayed for confirmation. 
The instance ID generated for this task is : id=i-0ab4c21be962806ac]

![image](https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/eeff466f-5bb4-40df-8f6e-67c0e5170c35)

Web Instance ID: id=i-0ab4c21be962806ac from the AWS Management Console

![image](https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/b66a9c4a-9ca3-4fd3-bc88-e2710f37e4a7)

To test connectivity from one instance to another.
Connect to an Instance using any method. For this task, I will be connecting to my instance via RDP

![image](https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/f633063a-5963-4f5f-93bf-30b3144b7c3d)

The ping and curl request keeps timing out.

![image](https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/c5bf37cd-c568-46ec-867a-86318c26c92f)

![image](https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/4360ce31-42f4-460f-852f-2e18d5eb46eb)


