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
        
        // Mengganti tahapan yang membutuhkan Docker dengan persiapan artifacts
        stage('Prepare Deployment Artifacts') {
            steps {
                // Arsipkan file-file yang diperlukan untuk deployment
                sh 'mkdir -p artifacts'
                sh 'cp -r src package.json package-lock.json artifacts/'
                sh 'tar -czf app-artifacts.tar.gz artifacts'
                archiveArtifacts artifacts: 'app-artifacts.tar.gz', fingerprint: true
            }
        }
        
        stage('Deploy to Staging') {
            when {
                branch 'development'
            }
            steps {
                // Menggunakan SSH untuk deploy ke server staging
                echo 'Deploying to staging server...'
                echo 'Dalam implementasi nyata, gunakan plugin SSH untuk transfer artifacts ke server'
                echo 'Dan jalankan script deployment di server tersebut'
                
                // Contoh simulasi deployment
                sh '''
                echo "Extracting artifacts..."
                mkdir -p staging
                tar -xzf app-artifacts.tar.gz -C staging
                echo "Application deployed to staging environment"
                '''
                
                echo 'Aplikasi berhasil di-deploy ke lingkungan staging'
                echo 'Staging URL: http://staging-server:3456 (simulasi)'
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