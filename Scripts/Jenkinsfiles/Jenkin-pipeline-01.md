pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/your-repo.git', branch: 'main'
            }
        }
        stage('Build') {
            steps {
                echo "Building the project..."
                sh 'echo build step'
            }
        }
        stage('Test') {
            steps {
                echo "Running tests..."
                sh 'echo test step'
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploying the project..."
                sh 'echo deploy step'
            }
        }
    }
}
