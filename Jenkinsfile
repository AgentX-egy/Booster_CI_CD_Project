pipeline{
    agent {label 'slave'}
    stages{
        stage('preparation'){
            steps{
                sh "git checkout ${env.GIT_BRANCH}"
            }
        }
        stage('build image'){
            steps{
                sh 'docker build -f dockerfile -t django:1.0b .'
            }
        }
        stage('push image'){
            steps{
                withCredentials([usernamePassword(credentialsId:"docker",usernameVariable: 'USERNAME',passwordVariable: 'PASSWORD')]){
                    sh 'docker login --username $USERNAME --password $PASSWORD'
                    sh 'docker push aboodyessam/django:1.0b'
                }
            }
        }
        stage('deploy'){
            steps{
                sh 'docker run -d -p 8000:8000 aboodyessam/django:1.0b'
            }
        }
    }
    post{
        success{
            slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME}  [${env.BUILD_NUMBER}]' (${env.BUILD_URL}console)")
        }
        failure{
            slackSend (color: '#E83009', message: "FAILURE: Job '${env.JOB_NAME} ${env.GIT_COMMIT} ${env.GIT_BRANCH} [${env.BUILD_NUMBER}]' (${env.BUILD_URL}console)")
        }
        aborted{
            slackSend (color: '#E8E209', message: "ABORTED: Job '${env.JOB_NAME}  [${env.BUILD_NUMBER}]' (${env.BUILD_URL}console)")
        }
    }
}
