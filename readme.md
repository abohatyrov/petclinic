# Sprint Petclinic CI Pipeline
This is a DevOps project that used open code app [Spring Petclinic](https://github.com/spring-projects/spring-petclinic)

## Project Overview
The project involves creating a Continuous Integration (CI) pipeline to build, test, and deploy the Spring Petclinic application using Jenkins and Terraform. The pipeline consists of several stages, including:

- Building the application from source code
- Running unit tests
- Building a Docker image of the application
- Pushing the Docker image to Docker Hub
- Uploading artifacts to a GCP bucket
## Infrastructure
The infrastructure for the project is created using Terraform. The following resources are created:

- A VPC to host the Jenkins instance and other resources
- A subnet within the VPC for the Jenkins instance
- A Jenkins instance with the necessary plugins installed
- A GCP bucket to store artifacts
- A Docker Hub account for storing Docker images

_Note: terraform files stored in different [repo](https://github.com/abohatyrov/petclinic-tf/)_
## CI Pipeline
The CI pipeline is implemented in Jenkins and is composed of several stages:

### Stage 1: Build
The first stage of the pipeline is to build the Spring Petclinic application from source code. This is done by cloning the source code from the GitHub repository and using Maven to build the application.

```Jenkinsfile
stage('Build') {
  steps {
    git branch: 'main', url: 'https://github.com/abohatyrov/petclinic.git'
    sh 'mvn clean -DskipTests package'
  }
}
```

### Stage 2: Test
The second stage of the pipeline is to run unit tests on the built application. This is done using the mvn test command.

```Jenkinsfile
stage('Tests') {
  steps {
    sh 'mvn test'
  }
}
```

### Stage 3: Build Docker Image
The third stage of the pipeline is to build a Docker image of the application. This is done by creating a Dockerfile that contains the necessary instructions to build the image. The Docker image is then built using the docker plugin in Jenkins.

```Dockerfile
FROM openjdk:21-slim-bullseye

ENV ARTIFACT_NAME=spring-petclinic-3.0.0-SNAPSHOT

WORKDIR /usr/lib/

COPY target/${ARTIFACT_NAME}.jar /usr/lib/

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "${ARTIFACT_NAME}.jar" ]
```
```Jenkinsfile
stage('Docker image') {
  steps {
    script {
      dockerImage = docker.build(registry)
      docker.withRegistry("", registryCredential) {
        dockerImage.push()
      }
    }
  }
}
```

### Stage 4: Save artifacts to GCS
This stage of the pipeline is to save artifacts on Google Cloud Storage. GCS plugin for Jenkins is used for this stage.
```Jenkinsfile
stage('Upload artifacts') {
  steps {
    googleStorageUpload bucket: "gs://$bucketName", credentialsId: googleCredential, pattern: "target/*.jar"
  }
}
``` 

### Stage 5: Cleanup
This stage of the pipeline is to clean all temp files. There are two steps in this stage: remove docker image from jenkins server using `docker rmi` command and delete all artifacts, because all artifacts was saved in a previous stage.
```Jenkinsfile
stage('Upload artifacts') {
  steps {
    googleStorageUpload bucket: "gs://$bucketName", credentialsId: googleCredential, pattern: "target/*.jar"
  }
}
```

