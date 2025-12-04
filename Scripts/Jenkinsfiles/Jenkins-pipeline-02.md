pipeline {
    agent any

    environment {
        APP_NAME = "myapp"
        DEPLOY_ENV = "dev"
    }

    parameters {
        string(name: 'BRANCH', defaultValue: 'main', description: 'Git branch to build')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: "${params.BRANCH}", url: 'https://github.com/your-repo.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    echo "Building ${env.APP_NAME} in ${env.DEPLOY_ENV}"
                    sh 'echo Build step executed'
                }
            }
        }

        stage('Test') {
            steps {
                echo "Running unit tests..."
                sh 'echo Test step executed'
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying ${env.APP_NAME} to ${env.DEPLOY_ENV}"
                sh 'echo Deploy step executed'
            }
        }
    }

    post {
        success {
            echo "Pipeline succeeded!"
        }
        failure {
            echo "Pipeline failed!"
        }
        always {
            echo "Pipeline finished!"
        }
    }
}
