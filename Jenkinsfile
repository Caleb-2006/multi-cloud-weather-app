pipeline {
    agent any

    environment {
        OWM_API_KEY = credentials('owm_api_key') // Optional if using Jenkins credentials
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/dhanuzz369/multi-cloud-weather.git'
            }
        }

        stage('Build Frontend') {
            steps {
                dir('website') {
                    sh 'docker build -t dhanu/mcw-frontend:latest .'
                }
            }
        }

        stage('Build Backend') {
            steps {
                dir('backend') {
                    sh 'docker build -t dhanu/mcw-backend:latest .'
                }
            }
        }

        stage('Deploy Containers') {
            steps {
                // Stop existing containers if any
                sh 'docker rm -f mcw-frontend || true'
                sh 'docker rm -f mcw-backend || true'

                // Run new containers
                sh 'docker run -d --restart unless-stopped -p 5001:5000 dhanu/mcw-frontend:latest'
                sh 'docker run -d --restart unless-stopped -p 5002:5000 --env OWM_API_KEY=$OWM_API_KEY dhanu/mcw-backend:latest'
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}