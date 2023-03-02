pipeline {
  agent any
  tools {
    maven 'M3'
  }
  stages {
    stage('Build') {
      steps {
        git branch: 'main', url: 'https://github.com/abohatyrov/petclinic.git'
        sh 'mvn clean package'
      }
    }
  }
}