# Sprint Petclinic DevOps
This is a DevOps project that used open code app [Spring Petclinic](https://github.com/spring-projects/spring-petclinic)

## What is done in this project
* Infrastructure as a Code
* CI/CD Pipeline
* Configuration management
* Monitoring
* Kubernetes cluster

## Technology stack
- Terraform             _was used to create the infrastructure_
- Google Cloud Platform _was used as a cloud provider_
- Jenkins               _was used to create create CI/CD Pipelines_
- Ansible               _was used for configuration management_
- Docker and K8s        _was used to host application_

## Infrastructure as a Code
In this project was used Terraform to create and manage infrastruction.

Provider:
- google

There are a module structure in project, so it`s easy to create resourses. Also templating was used to run scripts on instances.

All data has stored in different repository, there you can also find a description of the infrastructure and code. You can visit it, by clicking on the link bellow.
[Terraform repository](https://github.com/abohatyrov/petclinic-tf)

## CI/CD Pipeline
For manage CI/CD was choosen Jenkins, which located on server. 

Configuration backup per gcs bucket is used in this project. For this was installed `ThinBackup` and `Google Cloud Storage` plugins.

### CI Pipeline
#### Overview
This documentation outlines the Continuous Integration (CI) pipeline for our project, which is built using Jenkins. The pipeline includes the following stages:

* Checkout code from Git
* Running tests
* Building the application
* Saving the application to a GCS bucket

#### Pipeline stages
##### Checkout code from Git
The first stage of the pipeline is to check out the code from the Git repository. This is done using the "Git SCM" plugin in Jenkins. The plugin allows us to specify the repository URL and the branch to check out.

##### Running tests
The second stage of the pipeline is to run tests on the checked-out code. We use pytest to run tests. The tests can be run either locally or on a remote testing server, depending on the configuration. The tests are run using a Jenkins build step.

##### Building the application
The third stage of the pipeline is to build the application. We use a Dockerfile to build the application, and the build is performed using Docker. The Docker image is built using a Jenkins build step.

##### Saving the application to a GCS bucket
The final stage of the pipeline is to save the application to a GCS bucket. We use the Google Cloud SDK to interact with the GCS bucket. The SDK is installed on the Jenkins server. The application is saved to the GCS bucket using a Jenkins build step.