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
                    rm -rf maven-try-app
                    git clone https://github.com/louxer-crakers/maven-try-app
                    cd maven-try-app
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
    }
}