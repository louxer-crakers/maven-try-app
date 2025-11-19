pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh'''
                    git clone https://github.com/louxer-crakers/maven-try-app 
                    cd maven-try-app
                    mvn clean package
                '''
            }
        }
    }
}