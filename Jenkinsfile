node {
    stages {
        
        stage('GitHub Checkout') {
                git credentialsId: 'github', url: 'https://github.com/sanakhanlibre/my_flask_app'
        }

        stage('Build Docker image') {
                sh 'docker build -t sanakhanlibre/my_flask_app:latest'
        }

        stage('Push Docker Image') {
            withCredentials([string(credentialsId: '', variable: 'dockerhub')]) {
                sh 'docker login -u sanakhanlibre -p ${dockerhub}'
            }
            sh 'docker push sanakhanlibre/my_flask_app:latest'
        }
    }
}

