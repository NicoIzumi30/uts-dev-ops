output "app_container_id" {
  description = "ID of the application container"
  value       = docker_container.app.id
}

output "app_access_url" {
  description = "URL to access the application"
  value       = "http://localhost:3456"
}

output "prometheus_container_id" {
  description = "ID of the Prometheus container"
  value       = docker_container.prometheus.id
}

output "prometheus_access_url" {
  description = "URL to access Prometheus"
  value       = "http://localhost:9090"
}
