pipeline{

	agent { label 'linux' }
        options{
          buildDiscarder(logRotator(numTokeepStr: '5'))
}
	environment {
		DOCKERHUB_CREDENTIALS=credentials('divyarg0013-dockerhub')
	}

	stages {
	   
		stage('Build') {

			steps {
				sh 'docker build -t divyarg0013/heyy-nodejsexp:0.0.1.RELEASE .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push divyarg0013'
			}
		}
	}

	post {
		always {
			sh 'docker logout'
		}
	}

}
