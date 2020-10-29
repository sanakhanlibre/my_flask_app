pipeline {
    agent any

    triggers {
        pollSCM 'H/2 * * * *'
    }

    stages {

        stage('GitHub Checkout') {
            steps {
                git credentialsId: 'github', url: 'https://github.com/sanakhanlibre/my_flask_app'
            }
        }

        stage('Build Docker image') {
            steps {
                sh 'docker build -t sanakhanlibre/my_flask_app:v2 .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhub')]) {
                    sh 'docker login -u sanakhanlibre -p ${dockerhub}'
                }
                sh 'docker push sanakhanlibre/my_flask_app:v2'
            }
        }

        stage('Deploy App') {
            steps {
                script {
                    kubernetesDeploy(configs: "deployment.yaml", kubeconfigId: "kubeconfig")
                }
            }
        }
    }

    post {
        always {
            slack_notify(currentBuild.currentResult)
            cleanWs()
        }
    }
}

def slack_notify(String buildResult) {
    if ( buildResult == "SUCCESS" ) {
        slackSend color: "good", message: "Job: ${env.JOB_NAME} with buildnumber ${env.BUILD_NUMBER} was successful."
    }
    else if( buildResult == "FAILURE" ) { 
        slackSend color: "danger", message: "Job: ${env.JOB_NAME} with buildnumber ${env.BUILD_NUMBER} failed."
    }
    else if( buildResult == "UNSTABLE" ) { 
        slackSend color: "warning", message: "Job: ${env.JOB_NAME} with buildnumber ${env.BUILD_NUMBER} was unstable."
    }
    else {
        slackSend color: "danger", message: "Job: ${env.JOB_NAME} with buildnumber ${env.BUILD_NUMBER} its resulat was unclear." 
    }
}

