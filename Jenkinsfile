pipeline {
    agent any
    stages {
        stage('copy files to ansible server') {
            steps {
                script{
                    echo 'copying the files...'
                    sshagent(['ansible-server']){
                        sh "scp -o StrictHostKeyChecking=no ansible/* root@165.22.17.183:/root"

                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key',keyFileVariable:'keyFile',usernameVariable:'user')]){
                            sh "scp ${keyFile}  root@165.22.17.183:/root/ssh-key.pem"
                    }
                }
            }
        }
    }}}