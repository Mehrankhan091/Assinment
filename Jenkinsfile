pipeline {
    agent any
    
    tools {
        nodejs "nodejs"
    }
        
    stages {
        stage('Checkout Code') {
            steps {
                // That's it! Jenkins handles the rest automatically
                checkout scm
            }
        }
        
        // Your other stages...
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
            post {
                failure {
                    error('❌ Dependency installation failed!')
                }
            }
        }
        
        stage('Linter (ESLint)') {
            steps {
                sh 'npm run lint'
            }
            post {
                failure {
                    error('❌ ESLint check failed!')
                }
            }
        }
        
        stage('Formatter (Prettier)') {
            steps {
                sh 'npm run prettier -- --write'
            }
            post {
                failure {
                    echo '❌ Prettier formatting failed!'
                    echo 'Run: npm run prettier -- --write'
                    error('Formatting issues detected')
                }
            }
        }
        
        stage('Test (Jest)') {
            steps {
                sh 'CI=true npm run test'
            }
            post {
                failure {
                    error('❌ Tests failed!')
                }
            }
        }
        
        stage('Build') {
            steps {
                sh 'npm run build'
            }
            post {
                failure {
                    error('❌ Build failed!')
                }
            }
        }

            stage('Terraform Deploy') {
            steps {
                dir('terraform') {
                    script {
                        // Terraform Init
                        sh 'terraform init -input=false'
                        
                        // Terraform Plan (for visibility)
                        sh 'terraform plan -input=false -out=tfplan'
                        
                        // Terraform Apply (auto-approve for CI/CD)
                        sh 'terraform apply -input=false -auto-approve tfplan'
                    }
                }
            }
            post {
                failure {
                    error('❌ Terraform deployment failed!')
                }
            }
        }
    }
    
    
    post {
        always {
            echo "Pipeline ${currentBuild.currentResult}"
        }
        success {
            echo '✅ All stages passed successfully!'
        }
        failure {
            echo '❌ Pipeline failed! Check logs for errors.'
        }
    }

}