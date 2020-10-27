node {
    stages {
        
        stage('GitHub Checkout') {
                git credentialId: 'github', url: 'https://github.com/sanakhanlibre/my_flask_app'
        }

        stage('Build Docker image') {
                sh 'docker build -t sanakhanlibre/my_flask_app:latest'
        }

        stage('Push Docker Image') {
            withCredentials([string(credentialId: 'Docker_Password', variable: 'Docker_Password')]) {
                sh 'docker login -u sanakhanlibre -p ${Docker_Password}'
            }
            sh 'docker push sanakhanlibre/my_flask_app:latest'
        }
    }
}

