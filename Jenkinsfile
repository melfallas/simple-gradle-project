def SOURCEDIR = '/home/$LINUX_USER/jenkins/jenkins_home/workspace/${JOB_NAME}' 

pipeline {

    agent any

    environment {
  		//SOURCEDIR = '/home/ubuntu/jenkins/jenkins_home/workspace'
		//NAME = 'APP2'
		//ENV = 'ist'
		TEST='test'
		//TEST1='test'
		/*
		withCredentials([string(credentialsId: 'DGTOKEN', variable: 'DOMAIN_API_TOKEN')]) {
			DGTOKEN = ${DOMAIN_API_TOKEN}
		}
		*/
    }

    stages {
        stage('Build') {
            steps {
				//sh 'echo Procesing Build...'
				
                sh """
					./jenkins/build_stage/mvn.sh mvn -B -DskipTests clean package ${SOURCEDIR}
					./jenkins/build_stage/build.sh ${SOURCEDIR}
				"""
				
            }
        }                        
        stage('Test') {
            steps {
				sh 'echo Procesing Test...'
				//sh './jenkins/test_stage/test.sh mvn test ${SOURCEDIR}'
            }
        }
        stage('Push') {
            steps {
				sh 'echo Procesing Push...'
				//sh './jenkins/push_stage/push.sh app app localhost:5000'
            }
        }
        stage('Deploy') {
            steps {
				//sh 'echo Procesing Push...'
				sh '''
				./jenkins/deploy_stage/deploy_local.sh $CONTAINER_NAME $ENV $IMAGE_NAME $HOST_PORT $DOCKER_PORT $LINUX_USER $JOB_NAME
				./jenkins/deploy_stage/publish_local.sh
				'''
				/*
				withCredentials([string(credentialsId: 'DGTOKEN', variable: 'DOMAIN_API_TOKEN')]) {
					sh '''
					./jenkins/deploy_stage/deploy_local.sh $CONTAINER_NAME $ENV $IMAGE_NAME $HOST_PORT $DOCKER_PORT $LINUX_USER ${JOB_NAME}
					./jenkins/deploy_stage/publish_local.sh
					'''
				}
				*/
            }
        }
    }
}
