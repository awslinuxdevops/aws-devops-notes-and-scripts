
## Simple Deployment yaml file: 

![alt text](manifest_kind.png)

```
apiVersion: apps/v1
kind: Deployment
metadata: 
  name: my-app
spec: 
  replicas: 3 
  selector: 
   	matchLabels: 
    	app: my-app 
    template: 
    	metadata: 
      	labels: 
        	app: my-app 
        spec: 
        	containers: 
        	- name: my-app 
              image: my-app:v1 
              ports: 
          	  - containerPort: 8080
 
```


### Pod definition
-----------------
apiVersion: v1
kind: Pod
metadata:  
	name: my-app
spec:  
	containers:  
	- name: my-app    
	  image: my-app:1.0
	  
### Service definition
---------------------

apiVersion: v1
kind: Service
metadata:  
	name: my-service
spec:  
	selector:    app: my-app  
	ports:    
	- protocol: TCP      
	  port: 80      
	  targetPort: 9376	
===============================

# PersistentVolume
apiVersion: v1
kind: PersistentVolume
metadata:  
	name: my-pv
spec:  
	capacity:    
	storage: 1Gi  
	accessModes:    
	- ReadWriteOnce  persistentVolumeReclaim
	  Policy: Retain  
	  storageClassName: slow  
	  hostPath:    
	  path: "/mnt/data"
================================	  

---# PersistentVolumeClaim
apiVersion: v1
kind: PersistentVolumeClaim
metadata:  
	name: my-pvc
spec:  
	storageClassName: slow  
	accessModes:    
	  - ReadWriteOnce  
	resources:    
	  requests:      
	    storage: 500Mi

## Troubleshooting the issue:

apiVersion: v1
kind: Pod
metadata:
  name: nginx-deploy
  labels: 
    env: demo
spec:
  template: 
    metadata:
	  labels:
	    env: demo
	  name: nginx
	spec:
	  containers:
	  - image: nginx
	    name: nginx
		