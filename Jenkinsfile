pipeline {
    agent any
    environment {
        CN = 'langcab_ui'
    }
    stages {
        stage('Build dart') {
            steps {
                sh 'sudo docker build -t $CN .'
                sh 'sudo docker start langcab_db langcab_api ttt_api'
            }
        }
        stage('Deploy') {
            steps {
               sh 'sudo docker-compose up -d'
            }
        }
    }
}