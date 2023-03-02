pipeline {
  agent { maven: 'maven-3.8.7' }
  stages {
    stage('Build') {
      git url: 'https://github.com/cyrille-leclerc/multi-module-maven-project'
      withMaven {
        sh "mvn clean package"
      }
    }
  }
}