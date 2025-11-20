pipeline {
    agent {label 'agent1'}

    stages {

        stage('Install Dependencies') {
            steps {
                sh '''
                    sudo yum install git maven docker -y
                    sudo systemctl start docker
                '''
            }
        }

        stage('Build') {
            steps {
                sh '''
                    mvn clean package
                '''
            }
        }

        stage('Deploy to Docker Host') {
            steps {
                sh '''
                    sudo docker build -t maven-try-app:latest .
                    sudo docker rm -f hehe || true
                    sudo docker run -d --name hehe -p 8080:8080 maven-try-app:latest
                '''
            }
        }
        stage('Login and upload image') {
            steps {
                sh '''
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 419370949297.dkr.ecr.us-east-1.amazonaws.com
                    docker tag maven-try-app:latest 419370949297.dkr.ecr.us-east-1.amazonaws.com/hehe:latest
                    docker push 419370949297.dkr.ecr.us-east-1.amazonaws.com/hehe:latest
                '''
            }
        }
        stage('Reload service in ECS') {
            steps {
                sh '''
                    aws ecs update-service --cluster crafty-rhinoceros-iwalum --service hehet-service-v367vtkh --force-new-deployment
                '''
            }
        }
    }
}