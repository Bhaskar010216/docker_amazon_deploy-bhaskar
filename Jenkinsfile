pipeline {
    agent any
    environment {
        IMAGE_NAME = "amazon-app"
        CONTAINER_NAME = "amazon-binay"
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
                    // Remove if any existing container with the same name
                    sh "docker rm -f $CONTAINER_NAME || true"
                    
                    // Run container in detached mode with auto port assignment
                    sh "docker run -d --name $CONTAINER_NAME -p 0:8080 $IMAGE_NAME"
                    
                    // Wait for a few seconds to let Tomcat start
                    sleep 20
                    
                    // Check if container is running (basic health check)
                    def status = sh(script: "docker inspect -f '{{.State.Running}}' $CONTAINER_NAME", returnStdout: true).trim()
                    if (status != "true") {
                        error "Container failed to start"
                    }
                    
                    // Stop and remove test container after check (ignore errors)
                    sh "docker stop $CONTAINER_NAME || true"
                    sh "docker rm -f $CONTAINER_NAME || true"
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Ensure no container with same name exists
                    sh "docker rm -f $CONTAINER_NAME || true"
                    
                    // Run container detached for deployment on fixed port
                    sh "docker run -d --name $CONTAINER_NAME -p 9004:8080 $IMAGE_NAME"
                }
            }
        }
    }
}
