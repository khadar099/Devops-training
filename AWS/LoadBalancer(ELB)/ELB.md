Load Balancer
--------------
A Load Balancer in AWS is a managed service that automatically distributes incoming application traffic across multiple targets (such as EC2 instances, containers, or IP addresses) in one or more Availability Zones (AZs). It improves application scalability, fault tolerance, and availability.

Why Use a Load Balancer in AWS?
----------------------------------

✅ High Availability	Routes traffic only to healthy instances.

✅ Fault Tolerance	If one instance goes down, traffic is routed to others.

✅ Scalability	Automatically handles increased or decreased traffic.

✅ Security	Supports SSL/TLS termination and works with AWS WAF.

✅ Central Management	One endpoint for many backend services.

🔹 Types of Load Balancers in AWS (via ELB - Elastic Load Balancing)

Load Balancer Type	Best For	Protocols Supported	Target Type
--------------------------------------------------------------

1. Application Load Balancer (ALB)	Web apps (HTTP/HTTPS), microservices	HTTP, HTTPS	EC2, ECS, Lambda, IP

2. Network Load Balancer (NLB)	High-performance, low-latency apps	TCP, TLS, UDP	EC2, IP

 3. Gateway Load Balancer (GLB)	Third-party virtual appliances like firewalls	All IP traffic (L3)	IP

 4. Classic Load Balancer (Legacy)	Older apps using EC2-Classic	HTTP, HTTPS, TCP	EC2 only


When to Use Which?
---------------------
Use Case	Recommended Load Balancer

Host-based or path-based routing (e.g., /login, /api)	ALB

Real-time apps needing ultra-low latency	NLB

Deploying firewalls or IDS/IPS appliances	GLB

Simple EC2 web app (legacy/rarely used)	Classic ELB

Example Scenario: Your Bank App on EC2
You're running your app on:
http://13.127.72.112:8082/login

✅ Current Problem:
You have 1 EC2 instance. If it crashes or is overloaded, users will face downtime.

✅ Solution:
Use Application Load Balancer (ALB) because:

It's a web app using HTTP

You can register multiple EC2 instances behind the ALB

ALB provides health checks, so only healthy EC2s serve traffic




