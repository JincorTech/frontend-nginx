pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        sh 'docker-compose build'
      }
    }

    stage('Deploy') {
      when { branch 'develop' }

      steps {
        sh 'docker-compose push'
      }
    }
  }
}