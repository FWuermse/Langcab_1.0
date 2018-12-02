pipeline {
    agent any
    environment {
        CN = 'langcab_ui'
    }
    stages {
        stage('Undeploy UI') {
            steps {
                sh 'sudo docker stop $CN && sudo docker rm $CN'
                sh 'sudo docker rmi $CN'
            }
        }
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