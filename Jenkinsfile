pipeline {
    agent any
    stages {
        stage('Undeploy old UI') {
            steps {
                 sh 'sudo docker stop langcab_ui && sudo docker rm langcab_ui'
                 sh *sudo docker rmi langcab_ui'
             }
        }
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