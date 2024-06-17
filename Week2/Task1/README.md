                        Continuous Integration and Deployment (CI/CD)


The steps below highlights how I was able to implement the following:
•	Set up a CI/CD pipeline using GitHub Actions
•	Configure the pipeline to automatically build, test, and deploy an application (e.g., a simple web application or microservice). Could be anything from a simple Todo app to a complex microservice application. Sample Apps you could use: https://github.com/gothinkster/realworld ... https://github.com/search?q=sample%20todo&type=repositories
•	Implement automated testing (unit, integration, and end-to-end tests) as part of the CI/CD pipeline


For setting up a CI/CD pipeline for a cloud project using AWS, you can leverage several AWS services and tools to build, test, and deploy your application. 
Tools and Technologies
1.	AWS CodePipeline: Orchestrates the CI/CD pipeline.
2.	AWS CodeBuild: Builds and tests the code.
3.	AWS CodeDeploy: Deploys the application to various AWS services such as EC2, Lambda, or ECS.
4.	AWS S3: Stores build artifacts.
5.	AWS Elastic Beanstalk/ECS/EKS: Hosts the application.
6.	AWS RDS: Provides a managed database service.
7.	AWS CloudFormation: Manages infrastructure as code.
8.	GitHub: Source code repository and triggers for AWS CodePipeline.

I used the Realworld Todo app: https://github.com/gothinkster/realworld
The first step is to clone the realworl git repo

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/b7c76058-f2f3-4bdd-8771-acf7f09170a6">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/f0e40b1b-9163-47c8-99c3-f8ab93147b3a">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/dc26838e-241c-415c-9cda-95553fae54cb">

The resources were created successfully, However, I received a warning about the GitHub version 1 action provider being deprecated. It's recommended to use the GitHub version 2 action provider via a CodeStar Connection.

Updating to GitHub Version 2 Action Provider
To update to the GitHub version 2 action provider, you need to create a CodeStar connection and use it in your CodePipeline configuration.
Steps to Create a CodeStar Connection
This was found here https://docs.aws.amazon.com/dtconsole/latest/userguide/connections-create-github.html

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/be3d2f08-c27c-4d8f-8d9f-e250b2c1944e">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/ee3b5647-0581-44ce-b54d-36528570e6ed">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/48dc62ca-3693-4ae7-afcd-4a3d467110bd">

After creating the connection, we can reinitialize terraform.
I encountered another error, and modifications were made to my main.tf file

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/d40ae7ff-296c-422c-a8f4-525c2055263f">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/1ef7d2a9-f351-4b1a-b8e4-d731af06ed8d">

From the successful running of the terraform apply, I need to do the following:
•  Verify Resources: Ensure that all the resources you expected to be created are indeed present in your AWS account. You can check this by logging into the AWS Management Console and navigating to the respective services (e.g., S3 bucket, CodePipeline, CodeBuild).

My created S3 Bucket

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/1a7f7af9-fb00-416d-a8de-899a6b689096">

Code Pipeline

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/7f6065dd-6d64-4c45-bbf5-b4cf498fd113">

CodeBuild

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/12075971-075a-44bc-a7f2-56670ee79efc">

Testing the Pipeline
•  Go to the AWS CodePipeline console.
•  Locate the pipeline named codepipeline-realworld-todo.
•  Click on the pipeline name to view its details.
•  Click on "Release change" to manually trigger the pipeline execution.
•  Monitor the pipeline stages (Source, Build, Deploy) to ensure they complete successfully.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/3821b7ad-85e1-4b2c-950f-8d4276240bba">

The change release was successful. After applying the changes I will check the status and confirm.
<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/de592563-d9ce-46f5-8f77-f3927f5bea99">


