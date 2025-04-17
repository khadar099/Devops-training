Reference url - https://cloudzenia.com/blog/a-beginners-guide-to-deploying-a-kubernetes-cluster-on-ec2-instances-with-kubeadm/

Step 1: Set Up EC2 Instances

Using the AWS Management Console or AWS CLI, launch three EC2 instances: one for the master node and two for the worker nodes. Ensure that the AWS EC2 instances meet the minimum requirements for running Kubernetes, including sufficient CPU, memory, and network connectivity.

Some general guidelines for minimum requirements of an Amazon EC2 instance to run a Kubernetes cluster : 

Master Node: (t2.medium recommended)

CPU: 2 vCPUs or more

RAM: 4 GB or more

Disk: 20 GB or more (for system and application binaries)

Network: Sufficient bandwidth for communication between nodes and with external services

Worker Nodes:

CPU: 1 vCPU or more (depending on workload)

RAM: 2 GB or more

Disk: 20 GB or more (for system and application binaries)

Network: Sufficient bandwidth for communication between nodes and with external services
