pipeline {
  agent any
  tools {
    maven 'maven-3.8.7'
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