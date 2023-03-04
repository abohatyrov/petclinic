pipeline {
  agent any
  tools {
    maven 'maven-3.8.7'
  }
  stages {   
    stage('Build app') {
      git branch: 'main', url: 'https://github.com/abohatyrov/petclinic.git'
      sh 'mvn clean -DskipTests package'
    }

    stage('Tests') {
      sh 'mvn test'
    }

    stage('Upload artifacts') {
      googleStorageUpload bucket: 'gs://petclinic-artifacts-tf', credentialsId: 'petclinic-app', pattern: 'target/*.jar'
    }

    stage('Docker image') 
      steps {
        dockerImage = docker.build("abohatyrov/petclinic")

        withDockerRegistry([ credentialsId: "dockerhubaccount", url: "" ]) {
          dockerImage.push()
        }
      }
    }
  }
}