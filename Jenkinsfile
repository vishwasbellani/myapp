pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/vishwasbellani/myapp.git' // Corrected syntax
            }
        }
        stage('Build Docker Image') {  // Corrected from 'tages' to 'stage'
            steps {
                script {
                    echo 'Building Docker image...'
                    def app = docker.build("my-app:latest") // Make sure this name is valid
                }
            }
        }
        stage('Tag Docker Image') {
            steps {
                script {
                    // Tagging logic if necessary
                    // app.tag("my-app:7") // Ensure this tag follows the naming convention
                }
            }
        }
        stage('Push to Artifact Registry') {
            steps {
                script {
                    docker.withRegistry('https://us-central1-docker.pkg.dev', 'gcp-credentials') {
                        docker.image("my-app:${env.BUILD_ID}").push()
                        docker.image("my-app:latest").push()
                    }
                }
            }
        }
        stage('Deploy to GCP') {
            steps {
                script {
                    sh '''
                    ssh -o StrictHostKeyChecking=no vishwas24@34.93.200.65 "
                    docker pull asia-south1-docker.pkg.dev/vishwas24/my-repo/my-app:latest &&
                    docker run -d -p 80:80 asia-south1-docker.pkg.dev/vishwas24/my-repo/my-app:latest
                    "
                    '''
                }
            }
        }
    }  // Make sure all opening braces have a corresponding closing brace
}