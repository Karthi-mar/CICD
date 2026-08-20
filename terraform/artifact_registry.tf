resource "google_artifact_registry_repository" "webapp" {
    project = var.project_id
    location = var.region
    repository_id = var.repository_id
    format = "DOCKER"
    description = "Docker images for the devops webapp"

    depends_on = [google_project_service.artifact_registry]
}