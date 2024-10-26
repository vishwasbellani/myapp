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
                sh 'docker tag my-app asia-south1-docker.pkg.dev/vishwas24/my-app/my-app:latest'
                echo 'Completed Building Docker Image'
            }
        }

        stage('Docker Image Push to Artifact Registry') {
            steps {
                echo 'Pushing Docker Image to Artifact Registry: In Progress'
                withCredentials([file(credentialsId: 'my-gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
                    sh 'gcloud auth configure-docker asia-south1-docker.pkg.dev'
                    sh 'docker push asia-south1-docker.pkg.dev/vishwas24/my-app/my-app:latest'
                }
            }
        }
          stage('Deploy to Compute Engine Instance') {
            steps {
                echo 'Deploying to Compute Engine Instance'
                sh '''
                gcloud compute ssh vishwas24@my-app --zone asia-south1-c --command "
                    docker pull asia-south1-docker.pkg.dev/vishwas24/my-app/my-app:latest &&
docker run -d -p 80:80 asia-south1-docker.pkg.dev/vishwas24/my-app/my-app:latest
                    "
                '''
            }
        }
    }
}
