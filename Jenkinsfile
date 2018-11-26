pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'sudo docker stop ui && sudo docker rm ui'
                sh 'sudo docker rmi frontend'
                sh 'sudo docker build -t frontend .'
            }
        }
        stage('Deploy') {
            steps {
               sh 'echo comming soon'
            }
        }
    }
}