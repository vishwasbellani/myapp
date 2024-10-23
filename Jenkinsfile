pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Cloning the repository
                git 'https://github.com/vishwasbellani/myapp.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script { // Using script block for method calls
                    echo 'Building Docker image...'
                    def app = docker.build("my-app:latest") // Ensure this name is valid
                }
            }
        }
        stage('Tag Docker Image') {
            steps {
                script {
                    // Uncomment and ensure this tag follows the naming convention if you want to tag
                    // app.tag("my-app:7")
                }
            }
        }
        stage('Push to Artifact Registry') {
            steps {
                script {
                    // Pushing the Docker image to the registry
                    docker.withRegistry('https://us-central1-docker.pkg.dev', 'gcp-credentials') { registry ->
                        // Here, we use 'registry' as a closure parameter
                        docker.image("my-app:latest").push()
                        docker.image("my-app:${env.BUILD_ID}").push()
                    }
                }
            }
        }
        stage('Deploy to GCP') {
            steps {
                script {
                    // Deploying to GCP
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