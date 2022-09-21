
def CONTAINER_NAME = 'basic-app'
def ENV = 'dev'
def IMAGE_NAME = "${CONTAINER_NAME}"
def DOCKER_PORT = '9090'
def HOST_PORT = '5000'
def LINUX_USER = 'admin1'

def SOURCEDIR = "/home/${LINUX_USER}/jenkins/jenkins_home/workspace/${JOB_NAME}"

pipeline {

    agent any

    stages {
        stage('Build') {
            steps {
				//sh 'echo Procesing Build...'
				
                sh """
					echo --------------------------------------------------------------------------------------
					echo                             Procesing Build Stage ...
					echo --------------------------------------------------------------------------------------
					chmod +x jenkins/build_stage/mvn.sh
					chmod +x jenkins/build_stage/build.sh
					./jenkins/build_stage/mvn.sh mvn -B -DskipTests clean package ${SOURCEDIR}
					./jenkins/build_stage/build.sh $IMAGE_NAME ${SOURCEDIR}
				"""
				
            }
        }                        
        stage('Test') {
            steps {
				sh """
					echo --------------------------------------------------------------------------------------
					echo                             Procesing Build Stage ...
					echo --------------------------------------------------------------------------------------
				"""
				//chmod +x jenkins/test_stage/test.sh
				//sh './jenkins/test_stage/test.sh mvn test ${SOURCEDIR}'
            }
        }
        stage('Deploy') {
            steps {
				//sh 'echo Procesing Push...'
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
