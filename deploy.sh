#!/bin/bash

# Script untuk deployment otomatis aplikasi microservice
# Penggunaan: ./deploy.sh [environment] [version]
# Contoh: ./deploy.sh staging latest

ENVIRONMENT=$1
VERSION=$2

if [ -z "$ENVIRONMENT" ]; then
    echo "Error: Environment tidak dispesifikasikan."
    echo "Penggunaan: ./deploy.sh [environment] [version]"
    exit 1
fi

if [ -z "$VERSION" ]; then
    VERSION="latest"
    echo "Version tidak dispesifikasikan, menggunakan 'latest'"
fi

echo "Melakukan deployment ke lingkungan $ENVIRONMENT dengan versi $VERSION"

case $ENVIRONMENT in
    development)
        PORT=3000
        ;;
    staging)
        PORT=3456
        ;;
    production)
        PORT=80
        ;;
    *)
        echo "Error: Environment tidak valid. Gunakan 'development', 'staging', atau 'production'."
        exit 1
        ;;
esac

# Menghentikan container lama jika ada
docker stop $ENVIRONMENT-app || true
docker rm $ENVIRONMENT-app || true

# Menjalankan container baru
docker run -d --name $ENVIRONMENT-app -p $PORT:3000 devops-microservice-app:$VERSION

echo "Deployment ke $ENVIRONMENT berhasil!"
echo "Aplikasi dapat diakses di http://localhost:$PORT"