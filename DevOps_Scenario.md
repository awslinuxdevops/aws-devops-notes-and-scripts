# Complete DevOps Scenario Based Questions: 

## Troubeshooting DevOps Scenarios:

1. Application Downtime Due to Kubernetes Resources Constrainsts: 

#### What's Happening?

In kubernetes pods require resources like CPU and memory to function misconfigurd resource requests and limits or an improperlty tuned *Horizontal pod autoscaler* (HPA) can lead to resouce exhaustion, causing application downtime during tarffic spikes.

**Issue in Details:**

* Pods crashed due to ***OutOfMemory*** errors caused by insufficient allocation.

* The HPA was not configured properly, preventing scaling during traffic surges. 

**Resolution:**
1. Analyzing Metrics used Grafana dashboards and Prometheus data to identify resouce usage patterns.
2. Resource tuning updated resources requests and limits in the pod specification using a Helm chart.
```
resource:
  requests:
    memory: "512Mi"
    cpu: "500m"
  limits:
    memory: "1024Mi"
    cpu: "1"
```
3.  HPA configuration Setup HPA autoscaling:
```
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
spec:
  minReplicas: 2
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
      name: cpu
      target: utilization
      averageutilization: 70
```

4. Load Testing Simulated peak traffic using tools like *Apache JMeter* to validate changes.

2. Docker Image Vulnerabilities:

#### what"s Happening? 

Outdated base iamge in Docker can contain vulnerabilities pasing security risks to application and infrastructure.

**Issue in Details:**
* Critical vulnerabilities production images flagged by SonarQube.

**Resolution:**
1. Docker Image Update Update base image to latest version using Dockerfile.
2. *Idenitify  Vulnerabilities:* scanned image using **Trivy:**
```
trivy image --vulnerabilities <image-name>
```
3. Fix Vulnerabilities update Dockerfile to use latest base image.
4. Rebuild and redeploy updated image.
5. Verify image is free from vulnerabilities using Trivy.
6. *Switching Base Image:* Replaced outdated image with lightweight secure options like **distroless:**
```
FROM distroless/base
COPY app /app
CMD ["/app"]
```
7. *Automating Scans:* Integrated Trivy in Jenkins Pipeline: 
```
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t my-image .'



