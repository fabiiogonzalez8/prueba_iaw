pipeline {
    agent any
    stages {
        stage('Subir imagen') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'CREDENCIALES_DOCKERHUB', url: '']) {
                        def dockerImage = docker.build("fabiiogonzalez8/examen:${env.BUILD_ID}")
                        dockerImage.push()
                    }
                    sh "docker rmi fabiiogonzalez8/examen:${env.BUILD_ID}"
                }
            }
        }
        stage('SSH') {
            steps {
                script {
                    sshagent(credentials: ['clave']) {
                        sh "ssh -o StrictHostKeyChecking=no fabio@goku.supergallo.es wget https://raw.githubusercontent.com/fabiiogonzalez8/prueba_iaw/main/docker-compose.yaml -O docker-compose.yaml"
                        sh "ssh -o StrictHostKeyChecking=no fabio@goku.supergallo.es docker-compose up -d --force-recreate"
                    }
                }
            }
        }
    }
    post {
        always {
            mail to: 'fabiiogonzalez8@gmail.com',
            subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
            body: "${env.BUILD_URL} has result ${currentBuild.result}"
        }
    }
}
