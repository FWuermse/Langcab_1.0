pipeline {
    agent any
    environment {
        CN = 'langcab_ui'
    }
    stages {
        stage('Undeploy old version') {
            steps {
                sh 'sudo docker stop $CN && sudo docker rm $CN'
                sh 'sudo docker rmi $CN'
            }
        }
        stage('Build dart') {
            steps {
                sh 'sudo docker stop langcab_db langcab_api ttt_api'
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