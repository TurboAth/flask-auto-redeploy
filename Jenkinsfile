pipeline {
  agent any
  environment {
    PROJECT_DIR = "${env.HOME}/flask-auto-redeploy"
    HEALTH_URL  = 'http://127.0.0.1:5000/health'
  }
  triggers { cron('H/5 * * * *') } // every 5 minutes
  stages {
    stage('Checkout Code') {
      steps {
        git branch: 'main',
            url: 'https://github.com/atharvbyadav/flask-auto-redeploy.git'
      }
    }
    stage('Health Check & Redeploy') {
      steps {
        script {
          def status = sh(script: "curl -s -o /dev/null -w '%{http_code}' ${HEALTH_URL}", returnStdout: true).trim()
          if (status != '200') {
            echo "App unhealthy (${status}) — redeploying..."
            sh "bash ${PROJECT_DIR}/redeploy.sh"
          } else {
            echo "App healthy (${status})"
          }
        }
      }
    }
  }
}
