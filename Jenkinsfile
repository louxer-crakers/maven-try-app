pipeline {
    agent agent1

    stages {

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
                    docker build -t maven-try-app:latest .
                    docker rm -f hehe || true
                    docker run -d --name hehe -p 8080:8080 maven-try-app:latest
                '''
            }
        }
    }
}