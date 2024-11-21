pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
        }
        stage('Run image') {
            steps {
                sh 'docker build -t outcome-curr-mgmt .'
                sh 'docker run -d -p 9092:9092 outcome-curr-mgmt'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'mvn clean test'
            }
        }
        stage('Report') {
            steps {
                sh 'mvn verify'
            }
            post {
                always {
                    archiveArtifacts artifacts: 'outcome-curr-mgmt-coverage/target/site/jacocoaggregate/**/*', allowEmptyArchive: true
                }
            }
        }
    }
    post {
        always {
            script {
                sh '''
                    docker ps -a -q --filter "ancestor=outcome-curr-mgmt" | grep -q . && \
                    docker rm $(docker ps -a -q --filter "ancestor=outcome-curr-mgmt") || true
                    docker rmi outcome-curr-mgmt --force || true
                '''
            }
        }
        success {
            echo 'Pipeline executed successfully.'
        }
        failure {
            echo 'Pipeline execution failed.'
        }
    }
}
