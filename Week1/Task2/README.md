                                                              Monitoring and Logging

Install and Configure Prometheus
To install and configure Prometheus, you can follow these general steps. Please note that specific configurations might vary based on your environment and requirements.
1.	Download Prometheus:
o	Go to the Prometheus downloads page: Prometheus Download
o	Download the latest version for your operating system.
2.	Extract the Prometheus files:
o	Extract the downloaded file to a location on your system.
3.	Configure Prometheus:
o	Navigate to the Prometheus directory and locate the prometheus.yml file.
o	Open prometheus.yml in a text editor to configure the Prometheus server.
o	Configure scrape_configs to define the targets you want to monitor. 
In this case, I want to monitor my EC2 Instance.
The OS for the EC2 instance used was Windows as opposed to Unix.
o	This configuration will scrape metrics from a node exporter running on localhost:9100. You can add more jobs and targets as needed.
I added my instance and the IP address of my instance as the target.

![image](https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/30abc0f5-0c9a-4c02-ac82-ff95dac5dcd6)
![image](https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/76239cc0-7ebb-424c-8f6d-c73388098df1)

5.	Start Prometheus:
o	Run the Prometheus server by executing the prometheus executable. This will start the Prometheus server using the configuration specified in prometheus.yml.
![image](https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/8578a9f2-a756-4d7c-a273-c0345827ae20)

7.	Access Prometheus Web UI:
Open a web browser and navigate to http://localhost:9090 to access the Prometheus web interface.
Here, you can query metrics, view graphs, and manage Prometheus.

![image](https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/f06cf747-201f-4003-921d-e9be2683cf64)

Create Custom Metrics and Alerts
For Windows, you can use the "WMI Exporter" to export metrics about the Windows system for Prometheus. For a Unix system, the node exporter is used. Here's how you can set it up:
1.	Download the WMI Exporter:
Download the latest release of the WMI Exporter from the GitHub releases page.
2.	Install and Configure the WMI Exporter:
Extract the downloaded ZIP file to a location on your Windows server.
Open a command prompt as an administrator and navigate to the directory where you extracted the exporter.
![image](https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/a9a20294-9b30-4e23-9e1a-56c53824f338)
