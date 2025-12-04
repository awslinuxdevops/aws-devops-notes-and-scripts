pipeline {
    agent any

    environment {
        REGISTRY = "dockerhub/myapp"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/your-repo.git', branch: 'main'
            }
        }

        stage('Build & Test') {
            parallel {
                stage('Build Node.js') {
                    steps {
                        dir('node-service') {
                            sh 'docker build -t ${REGISTRY}/node-service:latest .'
                        }
                    }
                }
                stage('Build Python') {
                    steps {
                        dir('python-service') {
                            sh 'docker build -t ${REGISTRY}/python-service:latest .'
                        }
                    }
                }
                stage('Build Spring Boot') {
                    steps {
                        dir('spring-service') {
                            sh 'docker build -t ${REGISTRY}/spring-service:latest .'
                        }
                    }
                }
            }
        }

        stage('Push Images') {
            steps {
                sh 'docker login -u user -p password'
                sh 'docker push ${REGISTRY}/node-service:latest'
                sh 'docker push ${REGISTRY}/python-service:latest'
                sh 'docker push ${REGISTRY}/spring-service:latest'
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying services using docker-compose or kubectl..."
                sh 'docker-compose -f docker-compose.yml up -d'
            }
        }
    }

    post {
        success {
            echo "All services deployed successfully!"
        }
        failure {
            echo "Pipeline failed! Notifying team..."
        }
        always {
            echo "Cleaning up workspace..."
            cleanWs()
        }
    }
}
