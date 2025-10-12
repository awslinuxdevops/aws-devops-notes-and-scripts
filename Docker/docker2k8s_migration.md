# Docker Compose to Kubernetes

Migrating Docker compose to kubernetes involves translating the Docker Compose configuration
into Kubernetes configuration files. Here is an example of how to do it:

### Docker compose file of database:
```
version: '3'
services:
  web:
    image: my-web-app:latest
    ports:
      - "5000:5000"
    environment:  
      - DATABASE_URL=postgres://password:5432/mydatabase
    depends_on:
      - db
  db:
    image: postgres:13
    environment:
        POSTGRES_DB: mydatabase
        POSTGRES_USER: user
        POSTGRES_PASSWORD: password
```
## Migration to Kubernetes:

#### 1. **Create a Namespace (ptional):**

If you want to isolate your application, you can create a namespace.

#namespace.yaml
```
apiVersion: v1
kind: Namespace
metadata:
  name: my-namespace
```

#### 2. **Define ConfigMap for configuration (optional):**

#configmap.yaml
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: web-config
  namespace: my-app
data:
  DATABASE_URL: "postgres://password:5432/mydatabase"
```
#### 3. **Define Secrets for Sensitive Data:**

#secret.yaml
```
apiVersion: v1
kind: Secret
metadata:
  name: db-secret
  namespace: my-app
type: Opaque
data:
  POSTGRES_PASSWORD= dk3r5skd   # Base64 encoded password
```

#### 4. **Define Persistent Volume and Persistent Volume Claim for the Databases:**

#persistent-volume.yaml
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: db-pv
  namespace: my-app
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  hostPath:
    path: /mnt/data
```

#persistent-volume-claim.yaml
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: db-pvc
  namespace: my-app
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

#### 5. **Define Deployments for the Web App and Database:**

#web-deployment.yaml
```
apiVersion: app/v1
kind: Deployment
metadata:
  name: web-deployment
  namespace: my-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: web 
  template:
    metadata:
      labels: 
      app: web
    spec:
      containers:
        - name: web
          image: my-web-app:latest
          ports:
            - containerPort: 5000
          env:
            - name: DATABASE_URL
              valueFrom: 
                configMapKeyRef:
                  name: web-config
                  key: DATABASE_URL
    restartPolicy: Always
```         

#db-deployment.yaml
```
apiVersion: app/v1
kind: Deployment
metadata:
  name: db-deployment
  namespace: my-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: db 
  template:
    metadata:
      labels: 
      app: db
    spec:
      containers:
        - name: db
          image: postgress:13
          env:
            - name: DATABASE_DB
              value: mydatabase
            - name: POSTGRES_USER
              value: user
            - name: POSTGRES_PASSWORD
              valueFrom: 
                secretKeyRef:
                  name: db-secret
                  key: POSTGRES_PASSWORD
          volumeMounts:
            - name: db-storage
              mountPath: /var/lib/postgresql/data
    volumes:          
      - name: db-storage
        persistentVolumeClaim:
           claimName: db-pvc 
```           

#### 6. **Define Services for the Web App and Database:**

#web-service.yaml
```
apiVersion: v1
kind: Service
metadata:
  name: web-service
  namespace: my-app
spec:
  selector:
    app: web
  ports:
    - protocol: TCP
      port: 80
      targetPort: 5000
```
#db-service.yaml
```
apiVersion: v1
kind: Service
metadata:
  name: db-service
  namespace: my-app
spec:
  selector:
    app: db
  ports:
    - protocol: TCP
      port: 5432
```
### **Applying the Configuration:**

1. Create the namepace:
``` 
kubectl apply -f namepace.yaml 
```

2. Apply the ConfigMap and Secret: 
```
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
```
3. Create the Persistent Volume and Persistent Volume Claim:
``` 
kubectl apply -f persistent-volume.yaml
kubectl apply -f persistent-volume-claim.yaml 
```
4. Deploy the Web App and Database:
```
kubectl apply -f web-deployment.yaml
kubectl apply -f db-deployment.yaml
```
5. Create the Service:
```
kubectl apply -f web-service.yaml
kubectl apply -f db-service.yaml
```
### **Verify the Deployment**