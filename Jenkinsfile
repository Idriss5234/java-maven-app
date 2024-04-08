pipeline {
    agent any
    tools {
        maven 'maven-3.9.6'
        dockerTool 'docker-my'
    }
    stages {
        stage('test') {
            steps {
                echo 'testing the project...'
            }
        }
        stage('increment version') {
            steps {
                script {
                    echo 'Incrementing the image version...'
                    sh "mvn build-helper:parse-version versions:set -DnewVersion=\\\$\\{parsedVersion.majorVersion\\}.\\\$\\{parsedVersion.minorVersion\\}.\\\$\\{parsedVersion.nextIncrementalVersion\\} versions:commit"
                    def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = matcher[0][1]
                    env.IMAGE_VERSION = "${version}"
                }
            }
        }
        stage('Build') {
            steps {
                echo 'Building the project...'
                sh 'mvn clean package'
            }
        }
        stage('Dockerize') {
            steps {
                script {
                    echo 'Dockerizing the project...'
                    withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh "docker login -u $USERNAME -p $PASSWORD"
                        sh "docker build -t idriss5234/my-app:$IMAGE_VERSION ."
                        sh "docker push idriss5234/my-app:$IMAGE_VERSION"
                    }
                }
            }
        }
        stage('commit version update') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'pat-cred', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git config --global user.name "jenkins"'
                        sh 'git status'
                        sh 'git branch'
                        sh 'git config --list'
                        sh 'git remote set-url origin https://$GIT_USERNAME:${GIT_PASSWORD}@github.com/Idriss5234/java-maven-app.git'
                        sh 'git add .'
                        sh 'git commit -m "Incrementing version from Jenkins"'
                        sh 'git push origin HEAD:Jenkins-jobs'
                        sh "git config --global user.email"
                    }
                }
            }
}


        stage('Deploy') {
            steps {
                echo 'Deploying the project...'
            }
        }
    }
}
