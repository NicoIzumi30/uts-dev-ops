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
    }
    
    post {
        success {
            echo 'Build dan test berhasil! Siap untuk deployment.'
        }
        failure {
            echo 'Build atau test gagal! Tim developer harus segera memperbaiki masalah.'
        }
    }
}
