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
        stage('Install Dependencies') {
            steps {
                sh 'docker build -t myapp:v1'
            }
        }
        
        
        // stage('Build') {
        //     steps {
        //         sh 'npm run build'
        //     }
        // }
        
        // stage('Deploy to Nginx') {
            
        //     steps {
                
        //         sh './deploy_to_nginx.sh'
        //     }
        // }

        
        
        
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
