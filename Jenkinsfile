pipeline {
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
        
        stage('Build and Push') {
            steps {
               

                sh 'docker login -u menendezy -p 27042000jems'

                sh "docker build -t menendezy/myapp:v1 ."

                sh "docker push menendezy/myapp:v1"
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
