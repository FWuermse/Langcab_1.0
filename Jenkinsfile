pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'sudo docker build -t langcab_ui .'
            }
        }
        stage('Deploy') {
            steps {
               sh 'sudo docker-compose up -d'
            }
        }
    }
}