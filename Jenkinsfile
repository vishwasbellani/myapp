pipeline {
    agent any 

    environment {
        PROJECT_ID = 'vishwas24'
        IMAGE_NAME = 'my-app'
        IMAGE_TAG = 'latest'
        GCR_URL = "gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG}"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                echo 'Checking out code from Git'
                checkout scm
            }
        }

        stage('List Workspace Contents') {
            steps {
                sh 'ls -la' // List the contents of the workspace to check for Dockerfile
            }
        }

        stage('Building & Tagging Docker Image') {
            steps {
                echo 'Starting Building Docker Image'
                sh "docker build -t ${IMAGE_NAME} ."
                sh "docker tag ${IMAGE_NAME} ${GCR_URL}"
                echo 'Completed Building Docker Image'
            }
        }

        stage('Docker Image Push to Google Container Registry') {
            steps {
                echo 'Pushing Docker Image to GCR: In Progress'
                withCredentials([[$class: 'GoogleServiceAccountCredentialBinding', credentialsId: 'gcp-service-account-key']]) {
                    sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
                    sh 'gcloud auth configure-docker --quiet'
                }
                sh "docker push ${GCR_URL}"
                echo 'Pushing Docker Image to GCR: Completed'
            }      
        }
    }
}
