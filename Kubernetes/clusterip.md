💡 Use Case Scenario
Imagine you have two applications:

Backend API (shopping-backend) – handles business logic.

Frontend UI (shopping-frontend) – calls the backend via HTTP.

You want the frontend to talk to the backend internally, inside the Kubernetes cluster using a ClusterIP service.

🟩 Step 1: Backend Deployment (shopping-backend-deployment.yaml)

apiVersion: apps/v1
kind: Deployment
metadata:
  name: shopping-backend
  namespace: khadar
  labels:
    app: shopping-backend
spec:
  replicas: 2
  selector:
    matchLabels:
      app: shopping-backend
  template:
    metadata:
      labels:
        app: shopping-backend
    spec:
      containers:
      - name: backend
        image: khadar3099/shopping-app:v.8
        ports:
        - containerPort: 8080
🟦 Step 2: Backend ClusterIP Service (shopping-backend-service.yaml)

apiVersion: v1
kind: Service
metadata:
  name: shopping-backend-service
  namespace: khadar
spec:
  selector:
    app: shopping-backend
  ports:
    - protocol: TCP
      port: 80            # Port exposed to other services
      targetPort: 8080    # Port inside the backend container
  type: ClusterIP

  
🧠 Important: This service gives you an internal DNS name:

bash
Copy
Edit
http://shopping-backend-service.khadar.svc.cluster.local
🟨 Step 3: Frontend Deployment (shopping-frontend-deployment.yaml)

apiVersion: apps/v1
kind: Deployment
metadata:
  name: shopping-frontend
  namespace: khadar
  labels:
    app: shopping-frontend
spec:
  replicas: 2
  selector:
    matchLabels:
      app: shopping-frontend
  template:
    metadata:
      labels:
        app: shopping-frontend
    spec:
      containers:
      - name: frontend
        image: khadar3099/shopping-frontend:latest
        env:
        - name: BACKEND_URL
          value: "http://shopping-backend-service.khadar.svc.cluster.local"
        ports:
        - containerPort: 3000
        
✅ Now the frontend app can internally reach the backend using that ClusterIP service URL.


kubectl apply -f shopping-backend-deployment.yaml
kubectl apply -f shopping-backend-service.yaml
kubectl apply -f shopping-frontend-deployment.yaml
🔎 How to Test
You can exec into the frontend pod and use curl to check communication:


kubectl exec -it -n khadar <frontend-pod-name> -- sh

curl http://shopping-backend-service.khadar.svc.cluster.local
This verifies that the ClusterIP service is routing traffic to backend pods.
