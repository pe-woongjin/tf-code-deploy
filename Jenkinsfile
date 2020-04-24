pipeline {
  agent any
  stages {
    stage('Stage001') {
      steps {
        echo 'step001'
        sh 'ls'
        sleep 10
        archiveArtifacts(allowEmptyArchive: true, caseSensitive: true, artifacts: 'target', excludes: 'target/exclude/*')
      }
    }

  }
}