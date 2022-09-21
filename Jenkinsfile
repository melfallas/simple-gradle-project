
def CONTAINER_NAME = 'basic-app'
def ENV = 'dev'
def IMAGE_NAME = "${CONTAINER_NAME}"
def DOCKER_PORT = '9090'
def HOST_PORT = '5000'
def LINUX_USER = 'ubuntu'

def SOURCEDIR = "/home/${LINUX_USER}/jenkins/jenkins_home/workspace/${JOB_NAME}"

pipeline {

    agent any

    stages {
        stage('Build') {
            steps {
                sh """
					chmod +x jenkins/build_stage/compile.sh
					chmod +x jenkins/build_stage/build.sh
					./jenkins/build_stage/compile.sh $SOURCEDIR
					./jenkins/build_stage/build.sh $IMAGE_NAME $SOURCEDIR
				"""
				
            }
        }                        
        stage('Test') {
            steps {
				sh """
					chmod +x jenkins/test_stage/test.sh
					./jenkins/test_stage/test.sh $SOURCEDIR
				"""
				//chmod +x jenkins/test_stage/test.sh
				//sh './jenkins/test_stage/test.sh mvn test $SOURCEDIR'
            }
        }
        stage('Deploy') {
            steps {
				sh """
					chmod +x jenkins/deploy_stage/deploy_local.sh
					chmod +x jenkins/deploy_stage/publish_local.sh
					./jenkins/deploy_stage/deploy_local.sh $CONTAINER_NAME $ENV $IMAGE_NAME $HOST_PORT $DOCKER_PORT $LINUX_USER $JOB_NAME
					./jenkins/deploy_stage/publish_local.sh
				"""
            }
        }
    }
}
