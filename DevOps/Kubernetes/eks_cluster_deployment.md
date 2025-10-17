## Kubernetes & EKS Cluster Deployment

This repository contains YAML manifests, deployment steps, and architecture details for Kubernetes cluster setup using EKS and kubeadm.

### 1️⃣ Architecture
                   +-----------------+
                   |     Internet    |
                   +-----------------+
                            |
                        Load Balancer
                            |
                   +-----------------+
                   |   EKS Cluster   |
                   |  (Control Plane)|
                   +-----------------+
                            |
             +-------------------------------+
             |        Worker Nodes           |
             |  (EC2 instances / VMs)       |
             +-------------------------------+
             |   Pods & Deployments         |
             +-------------------------------+


* `Control Plane:` Managed by AWS (EKS) or self-managed (kubeadm)

* `Worker Nodes:` EC2 instances for pod scheduling

* `Services:` Exposed via LoadBalancer / NodePort / ClusterIP

### 2️⃣ Prerequisites

* AWS CLI configured with proper IAM permissions

* kubectl installed

* eksctl installed (for EKS)

* Terraform (optional, if infra is managed via IaC)

* Docker installed on worker nodes

### 3️⃣ EKS Cluster Deployment (Using eksctl)

##### Step 1: Create Cluster
```
eksctl create cluster \
--name my-cluster \
--version 1.28 \
--region ap-south-1 \
--nodes 3 \
--nodes-min 1 \
--nodes-max 4 \
--managed
```
##### Step 2: Verify Cluster
```
kubectl get nodes
kubectl get pods --all-namespaces
```

##### Step 3: Deploy Sample App
```
kubectl apply -f yaml/deployment.yaml
kubectl get pods
```

### 4️⃣ Kubeadm Cluster Deployment (Self-managed)

##### Step 1: Initialize Master Node
```
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
```

##### Step 2: Configure kubectl
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
##### Step 3: Join Worker Nodes
```
kubeadm join <master-ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```

##### Step 4: Apply CNI (Flannel)
```
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
```

### 5️⃣ YAML Files Structure

yaml/
├── deployment.yaml     # Sample app deployment
├── service.yaml        # Service exposure
├── ingress.yaml        # Ingress rules (if required)
├── configmap.yaml      # Configuration map
├── secret.yaml         # Secrets


#### Example Deployment YAML:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deploy
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
```