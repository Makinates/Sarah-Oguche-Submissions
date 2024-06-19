                                      Kubernetes Fundamentals

**Set up a Kubernetes cluster (e.g., using minikube, kind, or a cloud-based managed service)**

For this activity, I will set up the Kubernetes cluster using a cloud-based managed service, in this case AWS Elastic Kubernetes Service.

The prerequisites for implementation are:
1.	AWS CLI: You need the AWS Command Line Interface installed and configured with the appropriate permissions to create and manage EKS resources.
2.	kubectl: The Kubernetes command-line tool to interact with the cluster.
3.	eksctl: A command-line tool for creating and managing EKS clusters.

1.	Install AWS CLI on Mac
brew install awscli

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/8b641610-a51c-408a-8760-9b8fd436fa27">

Configure AWS with the AWS credentials
aws configure

<img width="293" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/82360cde-c9a8-4dee-9d88-811a0d504d95">

2.	Install kubectl
brew install kubectl

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/3dacd195-0d0e-497a-8c89-bb525af3e426">

3.	Install eksctl
brew tap weaveworks/tap
brew install weaveworks/tap/eksctl

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/90cea86f-b731-4d7e-888c-6b6512d6d957">

4.	Create the EKS Cluster
eksctl create cluster --name Sarah-Cluster1 --region us-east-1 --nodegroup-name linux-nodes --node-type t3.medium --nodes 2 --nodes-min 1 --nodes-max 3 –managed

Documentation can be found:

https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html

https://eksctl.io/

The command to create the EKS cluster will do the following:
•  eksctl create cluster: The command to create a new EKS cluster.
•  --name Sarah-Cluster1: Specifies the name of the cluster.
•  --region us-east-1: Specifies the AWS region where the cluster will be created.
•  --nodegroup-name linux-nodes: Specifies the name of the node group.
•  --node-type t3.medium: Specifies the EC2 instance type for the nodes.
•  --nodes 2: Specifies the initial number of nodes.
•  --nodes-min 1: Specifies the minimum number of nodes in the node group.
•  --nodes-max 3: Specifies the maximum number of nodes in the node group.
•  --managed: Indicates that the node group is a managed node group.


From the screenshot below of my CloudFormation, it shows the cluster creation is still in progress:

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/a0f0e6b2-6bb7-41c2-a149-547714b57fc0">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/b7cac6f0-d461-4bd8-8b7d-a9e4c0acd062">

The cluster has been successfully created.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/7accc747-12d4-4e1a-bbf4-ff2ed0e450e4">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/aa0c734c-f540-470c-9cb4-df5567ceb95c">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/45cfd88f-5e02-46f6-aaa4-a402fafa1706">





**Deploy and manage containerized applications on the Kubernetes cluster**

I will be deploying nginx

The first step is to create a deployment called “nginx”
kubectl create deployment nginx --image=nginx

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/ddc57b72-a14f-4cee-aa8c-5b7279ceecf0">


Expose the Nginx deployment to create a Kubernetes service:

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/b73332b2-6685-4174-ad59-38b5172453b1">


Check the status of the service:

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/fcfd5411-3d97-4c9c-bf57-49ecbea11fa2">

Access the Application
Once the external IP is assigned (this may take a few minutes), you can access the Nginx application using the external IP address in your web browser.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/06dec9d2-c673-4e70-afe5-776baf7ca0eb">

The app has been successfully deployed the screenshot below shows the external IP address provided.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/db9981ef-e3a0-4b77-ad6c-8708ba69e228">




**Configure and manage Kubernetes resources (e.g., Pods, Deployments, Services, ConfigMaps, Secrets)**

The first step is to view all deployments and ensure that the deployment and pods are running correctly.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/ddc6c046-a573-41f4-93b1-4c3c402c6ee5">

ConfigMaps
A ConfigMap is useful for injecting configuration data into your applications.
We create a configmap and then apply the configmap.

kubectl apply -f nginx-configmap.yaml

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/3f0d98fa-e566-4f42-8859-a08927bd9ea4">

Use the ConfigMap in the Deployment
Update the Nginx Deployment to use the created ConfigMap
Then apply the updated deployment.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/59a193d9-533f-4e6c-8ce5-ddf3ecac8d83">

Secrets
Secrets are used to manage sensitive information.

Create a Secret to store sensitive information such as passwords and apply the secret.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/907e6c1c-ea6f-4261-b2ca-efab7990923e">

Use the Secret in the Deployment
Update the Nginx Deployment to use the created Secret. Apply the updated deployment.

kubectl apply -f nginx-deployment-with-secret.yaml

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/49d6ae78-d349-4d01-b8fd-2cd79100eda5">

Services
Ensure the Service is correctly exposing the Deployment.

Check the Service status and get the external IP:
The external IP: aee173e68081d42a498a95f36315ea51-116943898.us-east-1.elb.amazonaws.com

Managing Resources
Some commands to manage resources are:

1.	Scaling the Deployment

To scale the Nginx deployment to 5 replicas: kubectl scale deployment nginx-deployment --replicas=5

2.	Check the status of the pods: kubectl get pods

3.	Updating the Deployment

To update the Nginx deployment to use a different image version:

kubectl set image deployment/nginx-deployment nginx=nginx:1.21.0

4.	Check the status of the rollout: kubectl rollout status deployment/nginx-deployment

5.	Viewing Logs
To view the logs of a specific pod: kubectl logs <pod-name>

6.	Deleting Resources

To delete the Nginx deployment, service, ConfigMap, and Secret:

kubectl delete deployment nginx-deployment

kubectl delete service nginx-service

kubectl delete configmap nginx-config

kubectl delete secret nginx-secret




**Implement scaling, self-healing, and rolling updates for deployed applications**

1. Scaling

Horizontal Pod Autoscaling (HPA)

Kubernetes provides the Horizontal Pod Autoscaler (HPA) to automatically scale the number of pod replicas based on CPU utilization or other select metrics.

1.	Enable Metrics Server (if not already enabled): The Metrics Server is required for HPA to function.
Install the Metrics Server:
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/c82dac6b-fb31-4a4a-b114-1491bed596a0">

2.	Create the HPA: Since I have an existing Nginx Deployment, create an HPA for it:

kubectl autoscale deployment nginx-deployment --cpu-percent=50 --min=1 --max=10

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/dca9dbb4-7287-4b27-9359-9219e757450d">

3.	Check the HPA Status:

kubectl get hpa

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/d16a3af2-1d9f-4777-aba9-f7f846eb6f8f">

2. Self-Healing

Kubernetes automatically provides self-healing capabilities through Deployments and ReplicaSets.
Health Probes

Implement readiness and liveness probes in the Nginx Deployment to ensure Kubernetes can detect and replace unhealthy pods.

Update the Deployment with Probes and apply the update:
<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/a7eba9c3-7fa5-467b-8e5d-00fee73f032f">

Verify the Deployment

Check the status of the deployment and the pods to ensure everything is running correctly:

kubectl get deployments

kubectl get pods

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/c5de0ef5-9fe3-48de-970d-770d2de868c1">

Rolling Updates

Kubernetes Deployments inherently support rolling updates. You can update your application without downtime by using kubectl set image or by updating the deployment manifest.

1.	Update the Image:
kubectl set image deployment/nginx-deployment nginx=nginx:1.21.0

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/457e547a-9d08-4c61-b146-8766282d096d">

Check the Rollout Status:

kubectl rollout status deployment/nginx-deployment

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/d0e81d2c-22ac-4c7f-9ce1-3e1815876532">

Update the Deployment Manifest with the new image and apply the update:
<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/c9f4b234-fbb0-4736-8a29-051ae4d2ace2">

Monitor the Rollout:

kubectl rollout status deployment/nginx-deployment

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/96495df5-caf8-455e-90e3-d16814701852">

