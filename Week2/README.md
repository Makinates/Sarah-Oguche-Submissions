               Implement container-based deployments using CI/CD pipelines

Build and run Docker containers for various applications (e.g., web servers, databases, message queues)


Building and Running the Docker Images
After creating the Dockerfile and application files, I built and ran the Docker images as follows:
Building the Docker image for nginx-docker

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/11eea599-c3b9-4414-a768-08da33697c99">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/68f2e586-fc28-4be7-a64a-d4d8fb2bd195">

Building the Docker image for flask-docker

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/0a2e5309-de0d-491a-a6db-6b608a2f485a">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/28b5f544-f7cd-4e97-858f-33a6ebdf8b02">

Create Multi-Container Applications Using Docker Compose

2.1. Create a Docker Compose File
1.	Create a directory for the multi-container application:
2.	Create a docker-compose.yml file:
3.	Create a directory for your Flask app and move your Flask files into it:
4.	Update the Dockerfile in the flask-app directory to expose port 5000:
5.	Create or update the index.html file:
6.	Start the multi-container application:

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/556800de-8068-4ee8-b3a0-135122cfe2ff">

Push and Pull Container Images to/from Docker Hub

3.1. Push to Docker Hub
1.	Login to Docker Hub:
<img width="438" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/c9625c7a-b646-4411-bf97-386d066f5852">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/8d01afc8-78ad-44a6-96f7-35a4f643461d">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/a55b7564-05b0-4f5b-9ecb-c9d2c2b3dee3">

Implement Container-Based Deployments Using CI/CD Pipelines
4.1. Set Up GitHub Repository and Actions
1.	Create a GitHub Repository
2.	Clone Your Repository
Clone the newly created repository  local machine:
3.	Add Project Files
Copy project files (including the Dockerfile and docker-compose.yml) into the cloned repository directory:
4.	Set Up GitHub Actions Workflow
Create a directory for GitHub Actions workflows:
Create a workflow file for building and deploying the Docker image:
5.	Commit and Push Changes
<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/224f8035-e1ef-4087-b248-debf07817353">


