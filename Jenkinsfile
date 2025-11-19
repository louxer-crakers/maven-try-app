pipeline {
    agent any

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
                script {
                    def remote = [
                        name: 'tomcat',
                        host: '35.174.60.5',
                        user: 'dockeradmin',
                        password: 'admin123',
                        allowAnyHosts: true
                    ]

                    sshPut remote: remote, 
                           from: 'maven-try-app/target/my-webapp.war',
                           into: '.'

                    sshPut remote: remote,
                           from: 'maven-try-app/Dockerfile',
                           into: '.'

                    sshCommand remote: remote, command: "docker build -t my-webapp-image ."
                    sshCommand remote: remote, command: "docker rm -f my-webapp-container || true"
                    sshCommand remote: remote, command: "docker run -d -p 8080:8080 --name my-webapp-container my-webapp-image"
                }
            }
        }
    }
}