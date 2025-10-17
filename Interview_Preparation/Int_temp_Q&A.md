## 1️⃣ Docker Image Tagging

"I handle Docker image tagging using ***semantic versioning*** like `1.0.0, 1.0.1` to track releases. I also tag images for different environments such as dev, staging, and prod, and include **CI/CD build numbers or commit hashes** like `1.0.0-build123.` This ensures images are immutable, traceable, and safe for rollback. During deployment, I push these tagged images to a container registry like ECR or DockerHub."

## 2️⃣ Trivy Scanning

"Trivy is a ***vulnerability scanner*** for Docker images. By default, it scans images for **OS and application vulnerabilities** and checks for **misconfigurations** like running containers as root. Trivy can also scan for secrets such as hardcoded passwords or API keys, but secret scanning is **not enabled by default;** we have to explicitly use `--security-checks` secret. I usually integrate Trivy into CI/CD pipelines to ensure only secure images are deployed to production."

## 3️⃣ Branching Strategies

"In my projects, I usually follow a **feature branching strategy.** Each new feature, bug fix, or improvement is developed in its own branch, for example feature/login-module. This keeps the main branch stable, allows multiple developers to work simultaneously, and makes code review easier through pull requests. Once a feature is complete, tested, and approved, it is merged back into the main branch. This strategy works well with CI/CD because each branch can be automatically built, tested, and scanned before merging."

## 4️⃣ EC2 vs ECS / Docker vs ECS

"EC2 provides virtual machines to host applications, but it doesn’t manage containers automatically. Docker allows us to package applications into containers. ECS, on the other hand, is a **container orchestration service** that runs and manages Docker containers on EC2 or using serverless Fargate. ECS handles scheduling, scaling, health checks, and deployments automatically. In short, Docker creates containers, and ECS manages and orchestrates them efficiently in production."