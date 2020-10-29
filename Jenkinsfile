pipeline {
    agent any

    try {

        notifyBuild('STARTED')

        stages {
        
            stage('GitHub Checkout') {
                steps {
                    git credentialsId: 'github', url: 'https://github.com/sanakhanlibre/my_flask_app'
                    checkout scm
                }
            }

            /*stage('Build Docker image') {
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
            }*/

            stage('Deploy App') {
                echo 'Deploying to Kubernetes'
                steps {
                    script {
                        kubernetesDeploy(configs: "deployment.yaml", kubeconfigId: "kubeconfig")
                    }
                }
            }
        }
    }
    catch (e) {
        currentBuild.result = "FAILED"
        throw e
    }
    finally {
        notifyBuild(currentBuild.result)
    }

    def notifyBuild(String buildStatus = 'STARTED') {

        buildStatus =  buildStatus ?: 'SUCCESSFUL'

        def color = 'RED'
        def colorCode = '#FF0000'
        def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
        def summary = "${subject} (${env.BUILD_URL})"
        def details = """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
            <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>"""

        if (buildStatus == 'STARTED') {
            color = 'YELLOW'
            colorCode = '#FFCC00'
        } 
        else if (buildStatus == 'SUCCESSFUL') {
            color = 'GREEN'
            colorCode = '#228B22'
        } 
        else {
            color = 'RED'
            colorCode = '#FF0000'
        }
        slackSend (color: colorCode, message: summary)
    }
}


