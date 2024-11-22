pipeline {
    agent { label 'nodo_docker' }
    
    environment {
        PORT = '8081:8081'
        NAMEIMAGE = 'outcome'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Construcción de la imagen Docker con el nombre especificado
                    echo 'Building Docker image...'
                    bat """
                    docker build -t ${NAMEIMAGE} .
                    """
                }
            }
        }

        stage('Run Container') {
         
            steps {
                script {
                    // Ejecución del contenedor con el puerto especificado
                    echo 'Running container...'
                    bat """
                    docker run -d -p ${PORT} ${NAMEIMAGE}
                    """
                }
            }
        }

        stage('Execute Tests') {
            
            steps {
                script {
                    // Ejecutar las pruebas del proyecto usando Maven
                    echo 'Running tests with Maven...'
                    bat 'mvn test'
                }
            }
        }
    }

    post {
        always {
            // Archivar artefactos, como reportes de JaCoCo
            archiveArtifacts artifacts: 'outcome-curr-mgmt-coverage/target/site/jacocoaggregate/**/*', allowEmptyArchive: true
        }
        
        success {
            // Mensaje cuando el pipeline se ejecuta exitosamente
            echo 'Pipeline completed successfully!'
        }
        
        failure {
            // Mensaje cuando el pipeline falla
            echo 'Pipeline execution failed. Please check the logs.'
        }
    }
}
