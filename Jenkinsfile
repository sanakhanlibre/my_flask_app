pipeline {
    agent any
    
    stages {
        stage("Checkout code") {
            steps {
                checkout scm
            }
        }
        stage("Build image") {
            steps {
                sh 'docker build -t sanakhanlibre/my_flask_app:latest .'
            }
        }
        stage("Push image") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                    sh 'docker push sanakhanlibre/my_flask_app:latest'
                }
            }
        }
    }
}