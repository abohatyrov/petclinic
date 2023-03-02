pipeline {
  agent any
  tools {
    maven 'maven-3.8.7'
  }
  stages {
    stage('Tests') {
      steps {
        sh 'mvn test'
      }
    }
    
    stage('Build') {
      steps {
        git branch: 'main', url: 'https://github.com/abohatyrov/petclinic.git'
        sh 'mvn clean -DskipTests package'
      }
    }

    stage('Upload artifacts') {
      steps {
        googleStorageUpload bucket: 'gs://petclinic-artifacts-tf', credentialsId: 'petclinic-app', pattern: 'target/*.jar'
      }
    }
  }
}