pipeline {
    agent any 

    environment {
        PROJECT_ID = 'vishwas24'
        IMAGE_NAME = 'my-app'
        IMAGE_TAG = 'latest'
        GCR_URL = "gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG}"
    }

    stages {
        stage('Code Compilation') {
            steps {
                echo 'Code compilation is starting'
                sh 'mvn clean compile'
                echo 'Code compilation is completed'
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
                withCredentials([file(credentialsId: 'gcp-service-account-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
                    sh 'gcloud auth configure-docker --quiet'
                }
                sh "docker push ${GCR_URL}"
                echo 'Pushing Docker Image to GCR: Completed'
            }
        }
    }
}
