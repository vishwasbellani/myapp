pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                script { // Explicit closure parameter list is not needed for a single expression
                    git 'https://github.com/vishwasbellani/myapp.git'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script { // Explicit closure parameter list
                    echo 'Building Docker image...'
                    def app = docker.build("my-app:latest") // Ensure this name is valid
                }
            }
        }
        stage('Tag Docker Image') {
            steps {
                script { // Explicit closure parameter list
                    // Uncomment and ensure this tag follows the naming convention if you want to tag
                    // app.tag("my-app:7")
                }
            }
        }
        stage('Push to Artifact Registry') {
            steps {
                script { // Explicit closure parameter list
                    docker.withRegistry('https://us-central1-docker.pkg.dev', 'gcp-credentials') {
                        // Correctly reference the docker image
                        docker.image("my-app:${env.BUILD_ID}").push()
                        docker.image("my-app:latest").push()
                    }
                }
            }
        }
        stage('Deploy to GCP') {
            steps {
                script { // Explicit closure parameter list
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
