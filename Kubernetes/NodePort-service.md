🧠 Why you're able to access the Pod from both nodes:
Even though the Pod is running on just one node, a NodePort service opens the same port (e.g., 30001) on every node in the cluster — not just the one where the Pod is running.

Kubernetes does this so that the service is reachable from any node's IP, regardless of where the actual Pod is scheduled.

🔄 How it works under the hood:
When you create a NodePort service:

Kubernetes configures each node to listen on the specified port (nodePort).

Traffic received on that port is routed to the correct Pod, even if the Pod is on a different node.

Kubernetes uses kube-proxy (which runs on all nodes) to handle this routing, usually via iptables or IPVS rules.

🔧 Example Scenario:
You have:

Node A (IP: 192.168.1.10)

Node B (IP: 192.168.1.11)

Pod is running only on Node A

Service with nodePort: 30001

Now:

http://192.168.1.10:30001 → hits Node A directly → traffic goes to the Pod.

http://192.168.1.11:30001 → hits Node B → kube-proxy forwards traffic to the Pod on Node A.

✅ This behavior is normal and by design:
It's for high availability — so clients don't need to know where the Pod is running.

This way, you can balance or fail over across nodes as Pods move or restart.

Bonus Tip:
If you want traffic to only go to the node where the Pod is running, you'd have to:

Use hostPort (ties it to a specific node — not recommended for general use).

Use DaemonSets with hostNetwork (each node runs the service directly).

Use externalTrafficPolicy: Local in a LoadBalancer service to preserve the client source IP and route only to local pods (advanced use case).

