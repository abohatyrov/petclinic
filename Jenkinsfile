pipeline {
  agent any
  tools {
    maven 'maven-3.8.7'
  }
  environment {
    bucketName = "petclinic-artifacts-tf"
    googleCredential = "petclinic-app"
    registry = "abohatyrov/petclinic"
    registryCredential = "dockerhubaccount"
    dockerImage = ""
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
        googleStorageUpload bucket: "gs://$bucketName", credentialsId: googleCredential, pattern: "target/*.jar"
      }
    }

    stage('Docker image') {
      steps {
        script {
          dockerImage = docker.build(registry)
          docker.withRegistry([ credentialsId: registryCredential, url: "" ]) {
            dockerImage.push()
          }
        }
      }
    }
  }
}