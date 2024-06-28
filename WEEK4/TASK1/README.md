                                                Infrastructure as Code with Terraform

1. Write Terraform Configurations to Provision and Manage Cloud Resources:

•	Define Terraform configuration files (main.tf, variables.tf, outputs.tf, provider.tf) for provisioning AWS resources like EC2 instances, VPCs, and RDS databases.

•	Use resource blocks and provider configurations to specify desired infrastructure state.

2. Use Terraform Modules for Reusable Infrastructure Components:

Organize Terraform configurations into reusable modules (module blocks) for common infrastructure patterns.

•	Parameterize modules with variables and outputs to customize their behavior.

Use Terraform Modules for Reusable Infrastructure Components:

•	Organize Terraform configurations into reusable modules (module blocks) for common infrastructure patterns.

•	Parameterize modules with variables and outputs to customize their behavior.

3 modules were created:

EC2 –  The files in the module are: main.tf, variables.tf, output.tf

RDS –  The files in the module are: main.tf, variables.tf, output.tf

VPC –  The files in the module are: main.tf, variables.tf, output.tf

3. Implement Terraform State Management and Collaboration Workflows:
•	Configure Terraform backends (e.g., AWS S3, Terraform Cloud) for remote state storage and locking to manage concurrent access and state consistency.
•	Use version control (e.g., Git) for Terraform configurations to track changes and facilitate collaboration.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/4b8cc85c-45d7-45ea-af85-c095b1b02a29">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/3fe7228c-115b-4f41-8ea9-c904e9957828">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/09185756-7cf5-4285-85fb-106fbfe6e7fb">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/48e4865d-0ea2-4035-a9dc-77d231d00e70">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/35e7eb27-9b6b-43d7-8157-f3223528a080">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/35b532a1-2d66-4bce-8a7d-3f9b86117cb3">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/d4a5c5b0-a652-462a-9f98-0d899d42aa71">



4. Deploy and Update Infrastructure Using Terraform in a CI/CD Pipeline:

•	Integrate Terraform commands (terraform init, terraform plan, terraform apply) into a CI/CD pipeline using GitHub Actions.

•	Automate infrastructure deployments triggered by changes to the Terraform configuration repository.




