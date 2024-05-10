pipeline {
    environment {
    registry = "menendezy/test-app"
    registryCredential = 'dockerhub'
    dockerImage = ''
    }

    agent any
    
    // Define NodeJS tool outside the agent block
    tools {
        nodejs 'nodejs'
    }
    
    stages {

        stage('devops'){
            steps{
            checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'githubtoken', url: 'https://github.com/menendezy22/devops.git']])

            }
        }
        stage('Building Docker Image') {
                steps {
                    script {
                        dockerImage = docker.build registry + ":$BUILD_NUMBER"
                    }
                }
            }

        stage('Deploying Docker Image to Dockerhub') {
                steps {
                    script {
                        docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                        }
                    }
                }
            }
        
        

        
        
        
    }
    
    post {
        success {
            echo 'Build succeeded! Send success notification...'
            echo 'Pipeline OK'
        }
        failure {
            echo 'Build failed! Send failure notification...'
            script {
                def failedStage = currentBuild.rawBuild.getCause(hudson.model.CauseOfInterruption)
                def errorMessage = failedStage?.toString() ?: "Unknown error"
                echo "Error message: ${errorMessage}"
            }
        }
    }
}
