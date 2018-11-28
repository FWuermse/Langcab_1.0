pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                sh 'echo Checkout successful'
            }
        }
        stage('Build') {
            steps {
                sh 'sudo docker stop langcab_ui && sudo docker rm langcab_ui'
                sh 'sudo docker rmi langcab_ui'
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