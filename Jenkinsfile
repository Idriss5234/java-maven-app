pipeline{
    agent any
    tools{
        maven 'maven-3.9.6'
        dockertTool 'docker-my'
    }
    stages{
        stage('test'){
            steps{
                echo 'testing the project...'
            }
        }
        stage('increment version'){
            steps{
                echo 'Incementing the image...'
                sh 'mvn build-helper:parse-version versions:set -DnewVersion=${parsedVersion.majorVersion}.${parsedVersion.minorVersion}.${parsedVersion.nextIncrementalVersion} versions:commit'
                def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                def version = matcher[0][1]
                env.IMAGE_VERSION = "$version-$BUILD_NUMBER"

            }
        }
        stage('Build'){
            steps{
                echo 'Building the project...'
                sh 'mvn clean package'
            }
        }
        stage('Dockerize'){
            steps{
                echo 'Dockerizing the project...'
                withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]){
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                    sh 'docker build -t my-app:$IMAGE_VERSION .'
                    sh 'docker push idriss5234/my-app:$IMAGE_VERSION'
                }
            }
        }
        stage('Deploy'){
            steps{
                echo 'Deploying the project...'
            }
        }
    }
}