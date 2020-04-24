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

    stage('Stage002') {
      parallel {
        stage('Stage002') {
          steps {
            echo 'hello'
          }
        }

        stage('Stage003') {
          steps {
            dir(path: 'target') {
              echo 'hello'
              sh 'ls -al'
            }

            sh '''date \'+%Ymd\'
'''
            sh 'local -a'
          }
        }

      }
    }

  }
}