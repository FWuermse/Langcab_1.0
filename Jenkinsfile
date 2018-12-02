pipeline {
    agent any
    environment {
        CN = 'langcab_ui'
    }
    stages {
        stage('Undeploy UI') {
            steps {
                if (sh 'sudo docker ps -q -f name=$CN' != null) {
                    if (sh 'sudo docker ps -aq -f status=exited -f name=$CN' == null) {
                        sh 'sudo docker stop $CN && sudo docker rm $CN'
                    }
                sh 'sudo docker rmi CN'
                }
                if (sh 'sudo docker images -aq -f reference=$SCN' != null) {
                    sh 'sudo docker rmi $SCN'
                }

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