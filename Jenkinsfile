pipeline {
    agent any

    stages {
        stage('Checkout SCM') {
            steps {
                echo 'Checking out code from Git'
                checkout scm
            }
        }

        stage('List Workspace Contents') {
            steps {
                sh 'ls -la'
            }
        }

        stage('Building & Tagging Docker Image') {
            steps {
                echo 'Starting Building Docker Image'
                sh 'docker build -t my-app .'
                sh 'docker tag my-app gcr.io/vishwas24/my-app:latest'
                echo 'Completed Building Docker Image'
            }
        }

        stage('Docker Image Push to Google Container Registry') {
            steps {
                echo 'Pushing Docker Image to GCR: In Progress'
                
                // Use the withCredentials block to access the service account key
                withCredentials([file(credentialsId: 'my-gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    // Authenticate Docker with GCP
                    sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
                    
                    // Set up Docker authentication
                    sh 'gcloud auth configure-docker'
                    
                    // Push the Docker image
                    sh 'docker push gcr.io/vishwas24/my-app:latest'
                }
            }
        }
    }
}
