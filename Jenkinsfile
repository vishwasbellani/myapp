pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/vishwasbellani/myapp.git' // Corrected syntax
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def app = docker.build("my-app:${env.BUILD_ID}")
                }
            }
        }
        stage('Tag Docker Image') {
            steps {
                script {
                    docker.image("my-app:${env.BUILD_ID}").tag("my-app:latest")
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
    }
}