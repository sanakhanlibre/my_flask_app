node() {
  def appName = 'my_flask_app'
  def imageTag = "sanakhanlibre/${appName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"

  checkout scm

  stage 'Build image'
  sh("docker build -t ${imageTag} .")

  stage 'Push image to registry'
  sh("docker push ${imageTag}")

  stage "Deploy Application"
  switch (env.BRANCH_NAME) {
    // Roll out to staging
    case "staging":
        sh("docker run -d --name=my_flask_app_staging -p 5001:5000 ${imageTag}")
        input 'looks good ?' 
        sh("docker rm -f staging_flask")
        break

    // Roll out to production
    case "master":
        input 'are you sure ?'
        sh("docker rm -f production_flask")
        sh("docker run -d --name=my_flask_app_production -p 5000:5000 ${imageTag}")
        break

    // Roll out a dev environment
    default:
        // Create namespace if it doesn't exist
        sh("docker ps")
  }
}