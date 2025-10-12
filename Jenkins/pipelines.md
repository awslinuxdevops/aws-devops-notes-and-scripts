# Jenkins Pipelines for Interview: 
---------------------------------
```
pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1'
        DOCKER_IMAGE = 'my-app-image'
        ECR_REPO = '123456789012.dkr.ecr.us-east-1.amazonaws.com/my-app-repo'
    }
    stages {
        stage('Checkout Code') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main', url: 'https://github.com/your-repo.git'
            }
        }
        stage('Build Code') {
            steps {
                echo 'Building the application...'
                sh '''
                # Example: Building a Java application
                mvn clean package
                '''
            }
        }
        stage('Run Tests') {
            steps {
                echo 'Running unit tests...'
                sh 'mvn test'
            }
        }
        stage('Docker Build and Push') {
            steps {
                echo 'Building Docker image...'
                sh '''
                docker build -t ${DOCKER_IMAGE}:latest .
                $(aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPO})
                docker tag ${DOCKER_IMAGE}:latest ${ECR_REPO}:${BUILD_NUMBER}
                docker push ${ECR_REPO}:${BUILD_NUMBER}
                '''
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying to Kubernetes...'
                sh '''
                kubectl set image deployment/my-app-deployment my-app-container=${ECR_REPO}:${BUILD_NUMBER} --record
                kubectl rollout status deployment/my-app-deployment
                '''
            }
        }
        stage('Monitor and Notify') {
            steps {
                echo 'Configuring monitoring and sending notifications...'
                sh '''
                # Example: Check application health
                curl -s http://my-app-url/health || exit 1
                '''
                mail to: 'team@example.com',
                     subject: "Deployment Successful: Build #${BUILD_NUMBER}",
                     body: "The deployment of build #${BUILD_NUMBER} was successful. Check the application at http://my-app-url/"
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
            mail to: 'team@example.com',
                 subject: "Deployment Failed: Build #${BUILD_NUMBER}",
                 body: "The deployment of build #${BUILD_NUMBER} failed. Check the Jenkins logs for details."
        }
    }
}
```

### Explanation for the Interview:
Pipeline Stages:

* **Checkout Code:** Fetches the source code from GitHub.
* **Build Code:** Compiles the code using tools like Maven.
* **Run Tests:** Runs unit tests to ensure code quality.
* **Docker Build and Push:** Builds a Docker image and pushes it to AWS ECR.
* **Deploy to Kubernetes:** Updates the Kubernetes deployment with the new Docker image.
* **Monitor and Notify:** Sets up application health checks and sends email notifications for success or failure.

#### Key Features of the Pipeline:

* Automates the entire CI/CD process, reducing manual effort. 
* Ensures deployment to Kubernetes is smooth and error-free.
* Includes monitoring and rollback mechanisms to handle failures.


**Faster delivery of applications.**
* Improved application stability and reliability.
* Seamless integration with cloud infrastructure (AWS) and orchestration (Kubernetes).


#### Jenkins Pipeline Create/Destory EKS cluster:
```
pipeline {
	agent any
		environment {
			AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
			AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
			AWS_DEFAULT_REGION = 'ap-south-1'
		}
		stages {
			stage('Checkout SCM'){
				steps{		
					script{
						checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/yeshwanthlm/EKS-Terraform-Jenkins.git']])
				}
			}
		}
		stage('Initializing Terraform'){
				steps{		
					script{
					    dir('terraform'){
					    	sh 'terrform init'
					}
				}
			}
		}
		stage('Validating Terraform'){
				steps{		
					script{
					    dir('terraform'){
					    	sh 'terrform validate'
					}
				}
			}
		}
		stage('Previewing the Infrastructure'){
				steps{		
					script{
					    dir('terraform'){
					    	sh 'terrform plan'
					}
					input(message: "Approve?", ok: "Proceed")
				}
			}
		}
		stage('Create/Destroy an EKS cluster'){
				steps{		
					script{
					    dir('terraform'){
					    	sh 'terrform $action --auto-approve'
					}
				}
			}
		}
    }
}
``` 


