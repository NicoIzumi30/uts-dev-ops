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
        
        stage('Check Directory Structure') {
            steps {
                sh 'find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" | sort'
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
                
                // Menyalin file-file dari lokasi yang benar
                sh '''
                echo "Menyiapkan artifacts untuk deployment..."
                
                # Salin package.json dan package-lock.json
                cp package.json artifacts/ || echo "package.json tidak ditemukan di root"
                cp package-lock.json artifacts/ || echo "package-lock.json tidak ditemukan di root"
                
                # Periksa dan salin dari struktur app/src jika ada
                if [ -d "app/src" ]; then
                  echo "Menyalin direktori app/src..."
                  mkdir -p artifacts/app
                  cp -r app/src artifacts/app/
                else
                  echo "Direktori app/src tidak ditemukan"
                fi
                
                # Periksa apakah ada Dockerfile di folder app
                if [ -f "app/Dockerfile" ]; then
                  echo "Menyalin Dockerfile dari folder app..."
                  cp app/Dockerfile artifacts/app/
                fi
                
                # Salin seluruh folder app jika ada
                if [ -d "app" ]; then
                  echo "Menyalin seluruh direktori app..."
                  cp -r app artifacts/
                fi
                
                # Buat file daftar untuk melihat struktur proyek
                find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" > artifacts/file_list.txt
                '''
                
                // Arsipkan semua konten untuk deployment
                sh 'tar -czf app-artifacts.tar.gz artifacts'
                archiveArtifacts artifacts: 'app-artifacts.tar.gz', fingerprint: true
                archiveArtifacts artifacts: 'artifacts/file_list.txt', fingerprint: true
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