pipeline {
  agent any
  tools {
    maven 'maven-3.8.7'
  }
  stages {   
    stage('Build app') {
      steps {
        git branch: 'main', url: 'https://github.com/abohatyrov/petclinic.git'
        sh 'mvn clean -DskipTests package'
      }
    }

    stage('Tests') {
      steps {
        sh 'mvn test'
      }
    }

    stage('Upload artifacts') {
      steps {
        googleStorageUpload bucket: 'gs://petclinic-artifacts-tf', credentialsId: 'petclinic-app', pattern: 'target/*.jar'
      }
    }

    stage('Image build') {
      steps {
        dockerImage = docker.build("abohatyrov/petclinic")
      }
    }

    stage('Image push') {
      steps {
        withDockerRegistry([ credentialsId: "dockerhubaccount", url: "" ]) {
          dockerImage.push()
        }
      }
    }
  }
}