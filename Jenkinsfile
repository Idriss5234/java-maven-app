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
    }
    stage("execute ansible playbook in ansible-server"){
        steps{
            script{
                echo "calling ansible playbook to configure ec2 instances"
                def remote = [:]
                remote.name = 'ansible-server'  
                remote.host = "165.22.17.183"
                remote.allowAnyHosts = true

                withCredentials([sshUserPrivateKey(credentialsId:'ansible-server',keyFileVariable:'keyFile',usernameVariable:'user')]){
                    remote.identityFile = keyFile
                    remote.user = user
                    remote.command = "ansible-playbook /root/ansible/my-playbook.yaml"
                    sshCommand remote
                }
            }
        }
    }    
    }}