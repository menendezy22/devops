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
                sh 'npm install'
            }
        }
        
        
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
        
        stage('Deploy') {
            steps {
                // Copy build files to Nginx directory
                sh 'cp -r build/* /usr/share/nginx/html/'

                // Restart Nginx
                sh 'sudo systemctl restart nginx'
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
