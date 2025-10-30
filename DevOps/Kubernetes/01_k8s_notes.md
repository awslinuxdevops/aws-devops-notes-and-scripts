# Core Kubernetes Concepts:

* Pods
* ReplicaSets
* Deployments
* Services
* ConfigMaps
* Secrets
* Namespaces
* Ingress
* Volumes

## 🔹 What is a Pod?

* Pod is the smallest deployable unit in Kubernetes.

* It wraps one or more containers that share:

    - Same network (IP)

    - Same storage (Volumes)

    - Same lifecycle

**Example:**
If you run an NGINX web server and a log sidecar, both run inside one pod.

### Example POD Yaml
```
apiVersion: v1
kind: Pod
metadata:
  name: mypod
  labels:
    app: nginx
spec:
  containers:
    - name: nginx
      image: nginx:latest
      ports:
        - containerPort: 80
```

###  Parameter Explanation:

| **Parameter**                            | **Meaning**                           | **Memory Tip**               |
| ------------------------------------ | --------------------------------- | ------------------------ |
| `apiVersion: v1`                     | Object version; Pods use v1       | “v1 = Core Resource”     |
| `kind: Pod`                          | Type of object                    | “What you’re creating”   |
| `metadata.name`                      | Pod name (unique in namespace)    | “Name tag”               |
| `metadata.labels`                    | Key-value tags used for grouping  | “Identity Badge”         |
| `spec.containers`                    | List of containers inside the Pod | “Pod recipe”             |
| `containers[].name`                  | Container name                    | “Nickname”               |
| `containers[].image`                 | Image name to run                 | “What container to cook” |
| `containers[].ports[].containerPort` | Port exposed inside container     | “Door number”            |


## 2. ReplicaSet (RS)

**🔹 What is a ReplicaSet?**

- Ensures desired number of identical Pods are always running.

- If one Pod dies → ReplicaSet creates a new one.

- If you scale up → RS creates more Pods.

### ReplicaSet (RS)
```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-rs
spec:
  replicas: 3
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
```


| **Parameter**              | **Description**                 | **Memory Tip**        |
| ---------------------- | --------------------------- | ----------------- |
| `replicas`             | Number of desired Pods      | “How many copies” |
| `selector.matchLabels` | Which Pods this RS controls | “Matching rule”   |
| `template`             | Blueprint of Pod            | “Pod DNA”         |


### Deployment

**🔹 What is a Deployment?**

- Manages ReplicaSets.

- Enables rolling updates, rollbacks, and version control.

- Automatically creates a ReplicaSet and manages Pods.


Used to manage ReplicaSets, allow rolling updates, rollback, and version control.
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
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
          image: nginx:1.21
          ports:
            - containerPort: 80

```
| Parameter         | Description                  | Memory Tip                  |
| ----------------- | ---------------------------- | --------------------------- |
| `replicas`        | Number of desired Pods       | Desired copies              |
| `selector`        | Which Pods to manage         | Label-based                 |
| `template`        | Pod spec                     | Defines what Pods look like |
| `strategy.type`   | RollingUpdate / Recreate     | Update style                |
| `metadata.labels` | Identifiers used by Services | Group tag                   |

```
# Common Commands
kubectl get deployments
kubectl rollout status deployment/nginx-deployment
kubectl rollout undo deployment/nginx-deployment
kubectl scale deployment nginx-deployment --replicas=5
```


## 🌐 4. Service
**🔹 What is a Service?**

- Stable networking for Pods.

- Pods’ IPs keep changing; Service provides a fixed endpoint (DNS name + ClusterIP).

- Routes traffic to Pods using labels.

| **Type**             | **Description**                       | **Access**                                |
| ---------------- | --------------------------------- | ------------------------------------- |
| **ClusterIP**    | Default; internal access only     | Inside cluster                        |
| **NodePort**     | Exposes Pods on a Node’s IP       | External on node’s port (30000–32767) |
| **LoadBalancer** | External Load Balancer (Cloud)    | Internet access                       |
| **ExternalName** | Maps service to external DNS name | No selector                           |
```
# Service YAML Example
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30080
```

| **Parameter**          | **Description**                              | **Memory Tip**                 |
| ------------------ | ---------------------------------------- | -------------------------- |
| `type`             | Service type (ClusterIP, NodePort, etc.) | Connectivity scope         |
| `selector`         | Matches Pods using labels                | “Whom to send traffic to?” |
| `ports.port`       | Service port (client-facing)             | Service entry point        |
| `ports.targetPort` | Pod’s containerPort                      | Destination inside Pod     |
| `ports.nodePort`   | External port on node (if type=NodePort) | Access via node IP         |


## 🧩 5. ConfigMap
**🔹 What is a ConfigMap?**

- Stores non-sensitive configuration data (env variables, properties).

- Keeps app code separate from configuration.

``` kubectl create configmap app-config --from-literal=DB_HOST=mysql --from-literal=DB_PORT=3306 ```

```
envFrom:
  - configMapRef:
      name: app-config
```

## 🔐 6. Secret
**🔹 What is a Secret?**

- Stores sensitive information (passwords, tokens).

- Values are Base64 encoded.

``` 
kubectl create secret generic db-secret --from-literal=DB_USER=root --from-literal=DB_PASS=admin123
```

## 🗂️ 7. Namespace
**🔹 What is a Namespace?**

- Logical separation in a cluster.

- Used for organizing and managing resources.
```
kubectl create namespace dev
kubectl get pods -n dev
```


## 🌍 8. Ingress
**🔹 What is Ingress?**

* Exposes HTTP/HTTPS routes from outside to inside the cluster.

* Provides:

  -  URL routing

  -  SSL termination

  -  Virtual host support
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
spec:
  rules:
    - host: myapp.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: nginx-service
                port:
                  number: 80
```

| Parameter                     | Description             |
| ----------------------------- | ----------------------- |
| `rules.host`                  | Domain name for routing |
| `paths.path`                  | URL path to match       |
| `backend.service.name`        | Target Service name     |
| `backend.service.port.number` | Service port            |


## 💾 9. Volumes
**🔹 What are Volumes?**

- Persistent storage attached to Pods.

🔹 Types

| Type                          | Description                               |
| ----------------------------- | ----------------------------------------- |
| `emptyDir`                    | Temporary storage (deleted when Pod dies) |
| `hostPath`                    | Uses host node filesystem                 |
| `PersistentVolume (PV)`       | Cluster-level storage resource            |
| `PersistentVolumeClaim (PVC)` | User request for PV                       |
| Cloud Volumes                 | EBS, NFS, AzureDisk, etc.                 |

```
apiVersion: v1
kind: Pod
metadata:
  name: volume-pod
spec:
  containers:
    - name: app
      image: nginx
      volumeMounts:
        - mountPath: "/data"
          name: my-storage
  volumes:
    - name: my-storage
      persistentVolumeClaim:
        claimName: my-pvc
```

```
apiVersion: v1
kind: Pod
metadata:
  name: volume-pod
spec:
  containers:
    - name: app
      image: nginx
      volumeMounts:
        - mountPath: "/data"
          name: my-storage
  volumes:
    - name: my-storage
      persistentVolumeClaim:
        claimName: my-pvc
```



### 🧍‍♂️ 1. Liveness Probe

- Checks if the container is alive and running.
If it fails → Kubernetes restarts the container automatically.
🧠 Remember: “Liveness = Is app alive?”

### 🧍‍♀️ 2. Readiness Probe

- Checks if the app is ready to receive traffic.
If it fails → Pod is temporarily removed from the Service.
🧠 Remember: “Readiness = Ready to serve?


### 🕒 3. Startup Probe

Used for apps that take long to start (e.g., large Java apps).
It runs first; if successful, then liveness/readiness start.
🧠 Remember: “Startup = Give app time to wake up.”

### ⚙️ 4. Rolling Update

Updates Pods one by one without downtime.
Old Pods terminate gradually as new Pods start.
🧠 Remember: “Rolling = Step-by-step update.”

### ⏪ 5. Rollback

If a new version fails, you can revert to the previous Deployment version.
Command: kubectl rollout undo deployment <name>
🧠 Remember: “Rollback = Go back safely.”

🧩 6. Horizontal Pod Autoscaler (HPA)

Automatically adds or removes Pods based on CPU/memory usage.
Command: ``` kubectl autoscale deployment nginx --min=2 --max=10 --cpu-percent=80  ```
🧠 Remember: “HPA = Traffic-based scaling.”

🧱 7. Vertical Pod Autoscaler (VPA)

Adjusts CPU and memory limits of Pods automatically.
Used for long-running apps with variable resource needs.
🧠 Remember: “VPA = Resize the Pod, not the count.”

🧑‍🤝‍🧑 8. Cluster Autoscaler

Adds or removes nodes (VMs) in a cluster automatically.
Useful for cloud-managed services like EKS, AKS, GKE.
🧠 Remember: “Cluster Autoscaler = Adds more machines.”

🔒 9. RBAC (Role-Based Access Control)

Controls who can do what in the cluster.
Uses Role, RoleBinding, ClusterRole, ClusterRoleBinding.
🧠 Remember: “RBAC = Permissions for users.”

👤 10. Service Account

Used by Pods to access Kubernetes API securely.
Each namespace has a default service account.
🧠 Remember: “Service Account = Identity for Pod.”

🌐 11. Network Policies

Control traffic flow between Pods.
Define which Pods can talk to others or to external IPs.
🧠 Remember: “NetworkPolicy = Firewall inside cluster.”

🧱 12. Node

A worker machine (VM) in Kubernetes that runs Pods.
Each node runs kubelet, kube-proxy, and the container runtime.
🧠 Remember: “Node = Machine that runs Pods.”

⚡ 13. Cluster

A group of nodes controlled by a Control Plane.
It’s the full Kubernetes environment.
🧠 Remember: “Cluster = Whole system of Nodes + Master.”

📦 14. Persistent Volume (PV)

Cluster-level storage resource.
It’s like a disk that can be attached to Pods via PVCs.
🧠 Remember: “PV = Storage offer.”

📜 15. Persistent Volume Claim (PVC)

Request for storage from a PV.
Pod uses PVC to mount the required disk.
🧠 Remember: “PVC = Storage request.”

🧰 16. StorageClass

Defines different types of storage (like EBS, SSD, HDD).
Kubernetes uses it to dynamically provision PVs.
🧠 Remember: “StorageClass = Template for PV.”

🧩 17. DaemonSet

Ensures one Pod runs on every node in the cluster.
Used for logging or monitoring agents (like Fluentd, Prometheus).
🧠 Remember: “Daemon = Runs everywhere.”

🧱 18. StatefulSet

Used for stateful applications (databases).
Gives fixed Pod names and persistent storage.
🧠 Remember: “StatefulSet = Sticky Pod.”

🕒 19. Job

Runs a task once until completion (e.g., backup or script).
Pod is deleted automatically after success.
🧠 Remember: “Job = One-time task.”

⏰ 20. CronJob

Runs a Job on a schedule (like a cron job).
Useful for backups, reports, and cleanups.
🧠 Remember: “CronJob = Scheduled job.”

💬 21. Labels

Key-value pairs used to group and select resources.
Services and Deployments use them to match Pods.
🧠 Remember: “Label = Tag to identify.”

🔍 22. Selectors

Used by Services or RS to find matching Pods.
They match the labels defined in Pod metadata.
🧠 Remember: “Selector = Who to choose.”

🗂️ 23. Annotations

Store non-identifying metadata (like version, build info).
Used by monitoring or logging tools.
🧠 Remember: “Annotation = Extra info note.”

📜 24. Resource Requests & Limits

Define CPU and memory needs for each container.
Requests = guaranteed; Limits = maximum allowed.
🧠 Remember: “Request = Minimum, Limit = Maximum.”

📊 25. Metrics Server

Collects CPU and memory usage for Pods and Nodes.
Used by HPA for scaling decisions.
🧠 Remember: “Metrics Server = Resource reporter.”

📈 26. Prometheus & Grafana

Prometheus = monitoring & metrics collection.
Grafana = beautiful dashboard visualization.
🧠 Remember: “Prometheus collects; Grafana displays.”

🧠 27. Troubleshooting Basics

Pod crash → kubectl logs <pod>

Pending Pod → kubectl describe pod <pod>

Service issue → check label match

LB pending → check cloud integration
🧠 Remember: “Describe → Why, Logs → What.”

☸️ 28. Helm

A package manager for Kubernetes.
Deploys complex apps (like Nginx, Jenkins) with one command.
🧠 Remember: “Helm = Kubernetes installer.”

☁️ 29. EKS / AKS / GKE

Managed Kubernetes by AWS / Azure / GCP.
They handle control plane, upgrades, and scaling.
🧠 Remember: “EKS = Kubernetes made easy.”

🔧 30. Imperative vs Declarative

Imperative: Direct commands (kubectl run nginx).

Declarative: Use YAML files (kubectl apply -f nginx.yaml).
🧠 Remember: “Imperative = Do now; Declarative = Maintain state.”

💥 31. CrashLoopBackOff Issue

Pod repeatedly crashes after restart.
Check logs & events: kubectl logs and kubectl describe.
🧠 Remember: “CrashLoop = Bad config or code error.”

🔗 32. ClusterIP vs NodePort vs LoadBalancer
Type	Use	Access
ClusterIP	Internal	Inside cluster
NodePort	Basic external	Node IP + Port
LoadBalancer	Cloud external	Public access
🧠 Remember: “Cluster = Inside, Node = On Node, LB = Internet.”		
🧾 33. Namespace Use Case

Used to isolate environments (dev, test, prod).
Each namespace has its own resources, quotas, and policies.
🧠 Remember: “Namespace = Environment boundary.”

🧑‍💻 34. Imperative Commands

Quick, on-the-fly resource creation.
Example: kubectl run nginx --image=nginx
🧠 Remember: “Fast testing, not for production.”

🔄 35. Declarative YAML

Stored in version control (Git).
Apply repeatedly — Kubernetes keeps it consistent.
🧠 Remember: “Declarative = Always match desired state.”