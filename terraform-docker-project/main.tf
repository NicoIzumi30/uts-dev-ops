# Buat network Docker
resource "docker_network" "app_network" {
  name = "microservice_network"
}

# Pull image untuk aplikasi
resource "docker_image" "app" {
  name = "devops-microservice-app:latest"
  keep_locally = true
}

# Buat container untuk aplikasi
resource "docker_container" "app" {
  name  = "microservice-app"
  image = docker_image.app.image_id
  
  ports {
    internal = 3000
    external = 3456
  }
  
  networks_advanced {
    name = docker_network.app_network.name
  }
  
  restart = "always"
}

resource "docker_image" "prometheus" {
  name = "prom/prometheus:latest"
}

resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = docker_image.prometheus.image_id
  
  ports {
    internal = 9090
    external = 9090
  }
  
  networks_advanced {
    name = docker_network.app_network.name
  }
  
  restart = "always"
}
