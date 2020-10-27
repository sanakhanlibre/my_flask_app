node('master') {
  try {

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
  catch(Exception e) {
    currentBuild.result = "FAILED"
    throw e
  }
  finally {
    notifyBuild(currentBuild.result)
  }
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
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#228B22'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  slackSend (color: colorCode, message: summary)
}