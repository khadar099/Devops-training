#What is a Namespace?#

A namespace is a Kubernetes object used to organize resources. By default, all Kubernetes resources exist in the default namespace unless specified otherwise.

Namespaces are especially useful when:

You have multiple teams sharing a cluster.

You want to isolate resources.

You need different environments (dev/test/prod) within the same cluster.

🔹 Key Concepts

**Isolation:**  
Resources in one namespace can't directly access those in another (unless explicitly configured).

**Scoped Resources:**  
Most Kubernetes objects (like pods, services, deployments, etc.) are namespace-scoped.

**Non-scoped Resources:**  
Some resources are cluster-scoped and not bound to any namespace (like Nodes, PersistentVolumes, and ClusterRoles).

**Built-in Namespaces**
Kubernetes creates some default namespaces:

default – Where resources go if no namespace is specified.

kube-system – Contains system components (like the API server, scheduler, controller-manager).

kube-public – Readable by all users, used for resources intended to be public (rarely used).

kube-node-lease – Manages node heartbeat leases (for scalability and performance).

**Creating a Namespace**

apiVersion: v1
kind: Namespace
metadata:
  name: my-namespace
  
**Apply it with:**

kubectl apply -f namespace.yaml

**Or directly:**

kubectl create namespace my-namespace

**Using a Namespace**
You can assign resources to a namespace like this:

apiVersion: v1
kind: Pod
metadata:
  name: my-pod
  namespace: my-namespace
spec:
  containers:
    - name: nginx
      image: nginx
      
**You can also set the namespace in your kubectl commands:**

kubectl get pods --namespace=my-namespace
Or set a default for your context:

kubectl config set-context --current --namespace=my-namespace

**Example Scenario**

Imagine you’re running two applications, App A and App B, in the same cluster but want to keep them isolated:

Create two namespaces: app-a and app-b.

Deploy all resources (pods, services, configmaps, etc.) for App A into app-a namespace.

Do the same for App B in app-b.

This way, both apps:

Have their own isolated environment.

Can use the same service names or configmaps without conflict.

Can be managed separately (limits, quotas, access control).

**Benefits of Namespaces**

Multi-tenancy: Run multiple apps or teams in a single cluster without interference.

Resource Quotas: Limit resources per namespace.

Access Control: Use RBAC (Role-Based Access Control) scoped to namespaces.

Organization: Clean separation of concerns.

🔹 Example: Quotas and RBAC
You can limit CPU/memory in a namespace:

yaml
Copy
Edit
apiVersion: v1
kind: ResourceQuota
metadata:
  name: mem-cpu-quota
  namespace: my-namespace
spec:
  hard:
    requests.cpu: "2"
    requests.memory: 1Gi
    limits.cpu: "4"
    limits.memory: 2Gi
You can also give a user access to only one namespace:

yaml
Copy
Edit
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: dev-access
  namespace: dev
subjects:
- kind: User
  name: alice
roleRef:
  kind: Role
  name: developer
  apiGroup: rbac.authorization.k8s.io
