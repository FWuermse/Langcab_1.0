pipeline {
    agent any
    environment {
        CN = 'langcab_ui'
    }
    stages {
        stage('Build dart') {
            steps {
                sh 'sudo docker build -t $CN .'
            }
        }
        stage('Deploy') {
            steps {
               sh 'sudo docker-compose up -d'
            }
        }
    }
}