pipeline {
    agent any
    stages {
        
        stage('GitHub Checkout') {
            steps {
                git credentialsId: 'github', url: 'https://github.com/sanakhanlibre/my_flask_app'
            }
        }

        stage('Build Docker image') {
            steps {
                sh 'docker build -t sanakhanlibre/my_flask_app:latest .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhub')]) {
                    sh 'docker login -u sanakhanlibre -p ${dockerhub}'
                }
                sh 'docker push sanakhanlibre/my_flask_app:latest'
            }
        }

        stage('Deploy App') {
            steps {
                script {
                    kubernetesDeploy(configs: "deployment.yaml", kubeconfigId: "kube_config")
                }
            }
        }

    }
}

