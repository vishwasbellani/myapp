 pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Cloning the repository directly
                git 'https://github.com/vishwasbellani/myapp.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                // Building the Docker image
                docker.build("my-app:latest")
            }
        }
        stage('Push to Artifact Registry') {
            steps {
                // Using Docker with registry credentials
                docker.withRegistry('https://us-central1-docker.pkg.dev', 'gcp-credentials') {
                    // Pushing the Docker image to the registry
                    docker.image("my-app:latest").push()
                }
            }
        }
        stage('Deploy to GCP') {
            steps {
                // Deploying to Google Cloud Platform
                sh '''
                ssh -o StrictHostKeyChecking=no vishwas24@34.93.200.65 "
                docker pull asia-south1-docker.pkg.dev/vishwas24/my-repo/my-app:latest &&
                docker run -d -p 80:80 asia-south1-docker.pkg.dev/vishwas24/my-repo/my-app:latest
                "
                '''
            }
        }
    }
}
