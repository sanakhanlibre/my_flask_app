pipeline {
    agent any
 
 environment {
    appName = "my_flask_app"
    imageTag = "sanakhanlibre/${appName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"
    }

 stages {
  stage('Docker Build and Tag') {
           steps {
                sh 'docker build -t ${imageTag} .' 
          }
        }
     
  stage('Publish image to Docker Hub') {
          steps {
            withDockerRegistry([ CreatedentialsId: "dockerhub", url: "https://hub.docker.com" ]) {
                sh  'docker push ${imageTag}' 
            }
          }
        }
     
  stage('Run Docker container on Jenkins Agent') {           
          steps {
            switch (env.BRANCH_NAME) {
              
              // Roll out to staging
              case "staging":
                sh("docker run -d --name=staging_flask -p 5001:5000 ${imageTag}")
                input 'looks good ?' 
                sh("docker rm -f staging_flask")
                break

              // Roll out to production
              case "master":
                input 'are you sure ?'
                sh("docker rm -f production_flask")
              sh("docker run -d --name=production_flask -p 5000:5000 ${imageTag}")
              break

              // Roll out a dev environment
              default:
                // Create namespace if it doesn't exist
                sh("docker ps")
            }
          }
        } 
    }
}