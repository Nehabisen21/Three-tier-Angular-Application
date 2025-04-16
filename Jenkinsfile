pipeline {
    agent any

    stages {
        
        stage('Workspace Cleanup') {
            steps {
                script {
                    // Clean up the workspace before starting the build
                    cleanWs()
                }
            }
        }

        stage('Clone Repository') {
            steps {
                echo 'Cloning repository...'
                git branch: "develop" , url: "https://github.com/Nehabisen21/Three-tier-Angular-Application.git"
            }
        }

        stage("Update Angular Endpoints") {
            steps {
                echo 'Updating Angular endpoints...'
                script {
                    dir("automate"){
                        // Update the Angular endpoint
                        sh 'chmod +x updateFile.sh'
                        // Execute the script to update the file
                        sh './updateFile.sh'
                    }
                }
            }
        }

        stage('Build') {
            steps {
                dir("spring-backend") {
                    echo 'Building Backend Spring Boot application...'
                    sh 'docker build -t spring-backend .'
                }

                dir("angular-frontend") {
                    echo 'Building Angular Frontend application...'
                    sh 'docker build -t angular-frontend .'
                }
            }
        }

        stage("Deploy application") {
            steps {
                echo 'Deploying application...'
                script {
                    dir("docker-compose") {
                        // Create docker network with name three-tier
                        sh 'docker network create three-tier'

                        // Run MySQL container in three-tier network
                        sh 'docker run -itd --name mysql --network three-tier -e MYSQL_ROOT_PASSWORD=springbackend -e MYSQL_DATABASE=springbackend mysql:latest' 

                        // Run Spring Boot container in three-tier network
                        sh 'docker run -itd --name spring-backend --network three-tier -p 8080:8080 spring-backend'

                        // Run Angular container in three-tier network
                        sh 'docker run -itd --name angular-frontend --network three-tier -p 80:80 angular-frontend'

                    }
                }
            }
        }
    }
}