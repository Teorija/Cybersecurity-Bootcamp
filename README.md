# Cybersecurity-Bootcamp
Linux and Ansible Scripts from my Cybersecurity Bootcamp

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![](Cybersecurity-Bootcamp\Elk\Diagrams\Vm Diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the files may be used to install only certain pieces of it, such as Filebeat.

- install-elk.yml
- filebeat-playbook.yml
- filebeat-config.yml
- metricbeat-playbook.yml
- metricbeat-config.yml

This document contains the following details:

- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of multiple DVWAs, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting traffic volume to the network.

- Load balancers protect the availability of the resources being requested. If a single server is receiving all the network traffic for resource requests it can get more requests than it is capable of handling. As a result that server could crash leading to resource requests being executed at all. A load balancer distributes the network traffic across multiple servers in order to mitigate this risk and ensure constant access to the resources being requested from users.
- Using a jump box (RedTeamVM) allows for restricted direct (SSH) access to the internal infrastructure of the network (web1, web2, web3, ElkVM). From the jump box an administrator can manage (edit and update) all machines on the network while restricting non administrative users to other access points of the network so they can request necessary resources.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the Virtual Machines and system metrics.

- Filebeat watches for 4 separate actions executed on the systems it's watching (dvwa - web1, web2, web3). The first thing it watches for is any sudo commands executed on the systems it's watching and reporting the user that performed it. The second thing that it watches for is any SSH login attempts made to the systems it's watching. The third thing that it watches for is if any new users or groups are made on the systems it's watching . The last thing Filebeat does it watch for all syslog activity on the systems it's watching. Overall Filebeat watches for actions performed on the systems it watches.
- Metricbeat records 4 separate metrics about the containers it's watching (dvwa - web1, web2, web3). The first things it records is the percentage of the container CPU being used at any time. The second thing it records is the percentage of the container memory being used at any time. The third thing it records is the size of memory (in MB) being used by a process in the containers main memory. The fourth thing it records is the network metrics of the containers it's watching, this includes the input traffic and output traffic to the container (in Bytes). 

The configuration details of each machine may be found below.

| Name      | Function                    | IP Address (private) | Operating System     |
| --------- | --------------------------- | -------------------- | -------------------- |
| RedTeamVM | Gateway                     | 10.0.0.4             | Linux (ubuntu 18.04) |
| Web1      | Host Site for Public Access | 10.0.0.5             | Linux                |
| Web2      | Host Site for Public Access | 10.0.0.6             | Linux                |
| Web3      | Host Site for Public Access | 10.0.0.7             | Linux                |
| ElkVM     | Host Kibana Monitoring Site | 10.1.0.4             | Linux (ubuntu 18.04) |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the load balancer can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:

- web1 - 10.0.0.5
- web2 - 10.0.0.6
- web3 - 10.0.0.7

Machines within the network can only be accessed by RedTeamVM

- The only machine with access to the ElkVM is from the jumpbox (RedTeamVM) - 10.0.0.4

A summary of the access policies in place can be found in the table below.

| Name      | Publicly Accessible                                          | Allowed IP Addresses                                  |
| --------- | ------------------------------------------------------------ | ----------------------------------------------------- |
| RedTeamVM | Yes/No (SSH access is available to anyone but shouldn't, only done for testing) | <should be just, personal ipv4 address> but is Any IP |
| Web1      | No                                                           | 10.0.0.4                                              |
| Web2      | No                                                           | 10.0.0.4                                              |
| Web3      | No                                                           | 10.0.0.4                                              |
| ElkVM     | Yes/No (SSH access is available to anyone but shouldn't, only done for testing) | <should be just, 10.0.0.4> but is Any IP              |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it saves time spent needlessly configuring machines as you can be managing a very large network. 

The playbook implements the following tasks:

- Install Pip3
- Install Docker Module
- Increase Virtual Memory
- Download and Launch Docker Elk Container (download image)
- Enable Docker Elk Container to Start on Boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](C:\Users\n3\Documents\Cybersecurity-Bootcamp\Cybersecurity-Bootcamp\Elk\Diagrams\elk instance.png)

### Target Machines & Beats

This ELK server is configured to monitor the following machines:

- web1 - 10.0.0.5
- web2 - 10.0.0.6
- web3 - 10.0.0.7

We have installed the following Beats on these machines:

- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:

- Filebeat - allows us to monitor the logs of the machines were watching recording things such as SSH logon attempts to the machine or sudo commands that were executed on the machine.
- Metricbeat - allows us to collect machine metrics such as the percentage of the CPU being used.

### Using the Playbook

In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:

- Copy the install-elk.yml file to /etc/ansible.

- Update the /etc/ansible/hosts file to include the machine(s) to install the Elk Docker on

  - [Elk]
    - 10.1.0.4

  and for specifying to install on the web virtual machines (eg, install filebeat and metricbeat),

  - [Webservers]
    - 10.0.0.5
    - 10.0.0.6
    - 10.0.0.7

- Run the playbook, and navigate to http://[ElkVM public IP address]:5601/app/kibana to check that the installation worked as expected.
