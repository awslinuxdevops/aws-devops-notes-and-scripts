# Jenkins Pipeline script for Terraform deployment: 
```
pipeline {
    agent any
       stages {
          stage("Terraform Init") {
            steps {
                sh 'terraform init'
            }
          }
          stage("Terraform Plan") {
            steps {
                sh 'terraform plan'
            }
          }
          stage("Terraform Apply") {
            steps {
                sh 'terraform apply --auto-approve'
            }
          }
       }
}
```

```

pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }
    }
}

```