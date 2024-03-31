pipeline {
    agent any
    tools{
        maven 'maven-3.9.6'
        dockerTool 'docker-my'   
         }
    stages {
        stage('Build jar') {
            steps {
                echo 'Building jar..'
                sh'mvn package'
            }
        }
         stage('Build image') {
            steps {
                echo 'Building docker image..'
                withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker build -t idriss5234/demo-app:1.1 .'
                    sh "docker login -u $USERNAME -p $PASSWORD"
                    sh'docker push idriss5234/demo-app:1.1'
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
              //  mvn test
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
   
}