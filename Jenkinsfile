pipeline {
    agent any
    environment {
        IMAGE_NAME = "amazon-app"
        CONTAINER_NAME = "amazon-test12"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/vivek6491/DOCEKR_AMAZON_DEPLOY_DEMO.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }
        stage('Test Image (Run Container)') {
            steps {
                script {
                    // Run container in detached mode
                    sh "docker run -d --name $CONTAINER_NAME -p 9018:8080 $IMAGE_NAME"
                    // Wait for a few seconds to let Tomcat start
                    sleep 20
                    // Check if container is running (basic health check)
                    def status = sh(script: "docker inspect -f '{{.State.Running}}' $CONTAINER_NAME", returnStdout: true).trim()
                    if (status != "true") {
                        error "Container failed to start"
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Remove previous container if any
                    sh "docker rm -f $CONTAINER_NAME || true"
                    // Run container detached for deployment
                    sh "docker run -d --name $CONTAINER_NAME -p 9018:8080 $IMAGE_NAME"
                }
            }
        }
    }
}
