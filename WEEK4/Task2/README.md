                                              Security Fundamentals

Network Architecture diagram

![image](https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/ac9fee75-36f2-4ef1-87e1-55ab1499ed78)


Components:
1.	AWS VPC: The Virtual Private Cloud environment.

2.	Public Subnet: Contains the Bastion Host for secure access.

3.	Private Subnet: Contains the Web Server running your application.

4.	Bastion Host: Allows secure SSH access to instances in the private subnet.

5.	Security Group: Controls inbound and outbound traffic to instances.

Notes:

•	The Bastion Host in the public subnet acts as a gateway for SSH access into the private subnet.

•	The Web Server (application) is deployed in the private subnet, not directly accessible from the internet.

•	Security Groups are applied to regulate traffic at the instance level, while NACLs (not depicted) would control traffic at the subnet level.

Part 1: Secure Network Architecture

1.	Virtual Private Cloud (VPC):

o	Purpose: Provides a dedicated virtual network environment in AWS.

o	Explanation: A VPC allows you to logically isolate your cloud resources, providing network-level segmentation. This isolation helps in controlling network traffic and applying security policies specific to your applications and services.

2.	Subnets:

o	Purpose: Segment the VPC into smaller networks for organization and security.

o	Explanation: Subnets help in organizing resources within a VPC by dividing it into distinct segments. Public subnets have direct internet access, suitable for resources like web servers, while private subnets are isolated from the internet and host backend services that do not need direct exposure.

3.	Security Groups:
o	Purpose: Control inbound and outbound traffic at the instance level.

o	Explanation: Security Groups act as virtual firewalls for your EC2 instances and other resources. They allow you to specify which traffic is allowed to reach your instances based on protocol, port, and source/destination IP addresses. This granular control helps in enforcing least privilege access.

4.	Network Access Control Lists (NACLs):
o	Purpose: Provide an additional layer of security at the subnet level.

o	Explanation: NACLs are stateless packet filters that control traffic entering and leaving subnets. Unlike Security Groups, which operate at the instance level, NACLs apply to all traffic in and out of the subnet. They help in setting broad rules for network traffic and can be used to create additional barriers against unauthorized access.

5.	Bastion Host (Jump Box):

o	Purpose: Securely access resources in the private subnet from the internet.

o	Explanation: The bastion host acts as a gateway through which administrators can securely access private instances without exposing them to the public internet. It serves as an entry point for SSH or RDP connections and is hardened with strict security configurations to minimize attack surfaces.

6.	Application Deployment:

o	Purpose: Deploy a web application securely within the private subnet.

o	Explanation: Deploying applications in the private subnet ensures that they are shielded from direct external access. This setup reduces exposure to potential threats and adheres to the principle of least privilege by restricting access to only those resources that truly require it.


IAM ROLES

1.	IAM Roles:

o	Purpose: Define roles with specific permissions for different functions.

o	Explanation: IAM roles help in delegating permissions to entities such as users, applications, or services. By assigning roles to individuals or systems, you enforce the principle of least privilege, ensuring that each entity has only the permissions necessary to perform its intended tasks.

aws iam create-role --role-name DeveloperRole --assume-role-policy-document file://developer-role-trust-policy.json

2.	IAM Policies:

o	Purpose: Attach policies to roles to control what actions they can perform.

o	Explanation: IAM policies are JSON documents that define permissions and can be attached to roles, users, groups, or resources. Policies specify which API actions are allowed or denied and on which resources. By crafting policies with least privilege in mind, you minimize the risk of unauthorized access or accidental misuse of permissions.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/d38e0a8d-04a8-4115-995c-b6436488626d">

3.	Multi-Factor Authentication (MFA):

o	Purpose: Add an extra layer of security to user authentication.

o	Explanation: MFA requires users to provide two or more verification factors to gain access—typically something they know (password) and something they have (smartphone app or hardware token). Enabling MFA strengthens account security by reducing the likelihood of unauthorized access, even if passwords are compromised.

Enable MFA for IAM users.

aws iam enable-mfa-device --user-name UserName --authentication-code1 123456 --authentication-code2 789012

Part 3: Secrets Management

1.	Secrets Management Solution (AWS Secrets Manager):

o	Purpose: Securely store and manage sensitive information.

o	Explanation: AWS Secrets Manager provides a centralized solution to store, access, and rotate secrets such as database credentials, API keys, and encryption keys. It helps in adhering to security best practices by reducing the risk of accidental exposure and enabling automated secret rotation for enhanced security posture.

Secrets Management Solution:

•	Use AWS Secrets Manager to store sensitive information.

Creating a Secret

aws secretsmanager create-secret --name MyDBSecret --secret-string '{"username":"admin","password":"password"}'

2.	Stored Secrets:

o	Purpose: Safeguard sensitive data from unauthorized access.

o	Explanation: Storing secrets securely ensures that critical information like passwords and API keys are protected from unauthorized access or inadvertent exposure. By centralizing secrets in a managed service like AWS Secrets Manager, you simplify access management and auditing while maintaining compliance with security standards.

Stored Secrets:
•	Store database credentials and API keys securely as secrets.
	
Retrieving a secret value

aws secretsmanager get-secret-value --secret-id MyDBSecret

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/6fac5d2c-d4d6-4017-b5f1-c1c76d079d71">

Part 4: Container and Kubernetes Security

1.	Container Security Best Practices:

o	Purpose: Secure Dockerized applications against potential vulnerabilities.

o	Explanation: Using minimal base images reduces the attack surface by eliminating unnecessary components. Running containers as non-root users limits the potential impact of compromised containers. Vulnerability scanning tools identify and mitigate security risks in container images, ensuring that only secure images are deployed.

2.	Kubernetes Security:

o	Purpose: Secure Kubernetes clusters and workloads against unauthorized access and threats.

o	Explanation: Network policies control traffic flow to and from pods based on pod labels, enforcing segmentation and restricting communication to authorized services. Pod security policies enforce security standards by defining conditions and restrictions that pods must adhere to, such as running with non-root privileges or using specific security contexts. Kubernetes secrets securely store sensitive information like passwords or API keys, ensuring they are only accessible to authorized pods and applications.






