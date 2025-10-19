# Jenkins Shared Library - vars Folder

This repository contains **reusable Jenkins pipeline functions** stored in the `/vars` folder for use across multiple pipelines.

## Structure
vars/
├── buildApp.groovy # Build Java/Maven apps
├── runTests.groovy # Run Unit/Integration tests
├── dockerBuildPush.groovy # Build & Push Docker images
├── deployToAWS.groovy # Deploy apps to EC2
├── notifySlack.groovy # Slack notifications
└── helper.groovy # Helper functions for logging


## How to Use
1. Import the shared library in your Jenkinsfile:
```groovy
@Library('jenkins-shared-library') _

2. Call any function directly in your pipeline:

buildApp('inventory-service')
runTests('inventory-service', true, false)
dockerBuildPush('inventory-service', '123456789012.dkr.ecr.us-east-1.amazonaws.com', 'v1.0.0')
deployToAWS('inventory-service', 'dev', '54.123.45.67')
notifySlack('#ci-cd-notifications', 'Deployment Success', true)


## Example /vars/ Functions:
```
@Library('jenkins-shared-library') _

pipeline {
    agent any
    environment {
        APP_NAME = "inventory-service"
        DOCKER_REPO = "123456789012.dkr.ecr.us-east-1.amazonaws.com"
        ENV = "dev"
        INSTANCE_IP = "54.123.45.67"
        SLACK_CHANNEL = "#ci-cd-notifications"
    }

    stages {
        stage('Init') {
            steps {
                helper(APP_NAME, ENV)
            }
        }

        stage('Build') {
            steps {
                buildApp(APP_NAME)
            }
        }

        stage('Test') {
            steps {
                runTests(APP_NAME, true, false)
            }
        }

        stage('Docker') {
            steps {
                dockerBuildPush(APP_NAME, DOCKER_REPO, "v1.0.0")
            }
        }

        stage('Deploy') {
            steps {
                deployToAWS(APP_NAME, ENV, INSTANCE_IP)
            }
        }
    }

    post {
        success {
            notifySlack(SLACK_CHANNEL, "✅ ${APP_NAME} deployed successfully to ${ENV}", true)
        }
        failure {
            notifySlack(SLACK_CHANNEL, "❌ ${APP_NAME} deployment failed in ${ENV}", false)
        }
    }
}
```

