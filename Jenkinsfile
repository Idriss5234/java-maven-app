pipeline{
    agent any
    stages{
        stage('test'){
            steps{
                echo 'testing the project...'
            }
        }
        stage('build'){
            when{
                expression{
                    BRANCH_NAME == 'main'
                }
            }
            steps{
                echo 'building the project...'
            }
        }
        stage('Deploy'){
            steps{
                echo 'Deploying the project...'
            }
        }
    }
}