pipeline {
    agent any
    stages {
        stage('copy files to ansible server') {
            steps {
                script{
                    echo 'copying the files...'
                    sshagent(['ansible-server']){
                        sh "scp -o StrictHostKeyChecking=no ansible/* root@164.90.188.58:/root"

                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'ec2-server-key',keyFileVariable:'keyFile',usernameVariable:'user')]){
                            sh "scp ${keyFile}  root@164.90.188.58:/root/ssh-key.pem"
                    }
                }
            }
        }
    }}}