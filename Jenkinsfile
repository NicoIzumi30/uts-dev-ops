pipeline {
    agent any
    
    tools {
        nodejs 'Node22'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        
        stage('Run Tests') {
            steps {
                sh 'npm test'
            }
        }
        
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops-microservice-app:${BUILD_NUMBER} .'
                sh 'docker tag devops-microservice-app:${BUILD_NUMBER} devops-microservice-app:latest'
            }
        }
        
        stage('Deploy to Staging') {
            when {
                branch 'development'
            }
            steps {
                sh '''
                # Menghentikan container lama jika ada
                docker stop staging-app || true
                docker rm staging-app || true
                
                # Menjalankan container baru dengan image terbaru
                docker run -d --name staging-app -p 3456:3000 devops-microservice-app:latest
                '''
                
                echo 'Aplikasi berhasil di-deploy ke lingkungan staging'
                echo 'Staging URL: http://localhost:3456'
            }
        }
        stage('Notify Deployment') {
            steps {
                slackSend channel: '#deployments',
                        color: 'good',
                        message: "Deployment ke staging berhasil: ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)"
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline CI/CD berhasil! Aplikasi siap di lingkungan staging.'
        }
        failure {
            echo 'Pipeline CI/CD gagal! Tim developer harus segera memperbaiki masalah.'
        }
    }
}
