pipeline {
    agent any
    environment {
    }
    stages {
        stage('Build') {
            steps {
                sh 'echo hello world'
            }
        }
    }
}
