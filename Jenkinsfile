pipeline {
    agent any
    environment {
        CN = 'langcab_ui'
    }
    stages {
        stage('Build dart') {
            steps {
                sh 'sudo docker stop $(sudo docker ps -a -q)'                
                sh 'sudo docker build -t $CN .'
                sh 'sudo docker start $(sudo docker ps -a -q)'
            }
        }
        stage('Deploy') {
            steps {
               sh 'sudo docker-compose up -d'
            }
        }
    }
}