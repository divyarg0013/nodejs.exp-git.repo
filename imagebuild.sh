pipeline {

  environment {
    #  Dockerhub login/dockerhubrepo
    dockerimagename = "thetips4you/nodeapp"
    dockerImage = ""
  }
 #not Specifing any slave particularly
  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/divyarg0013/nodejs.exp-git.repo.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhublogin'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }