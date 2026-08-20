resource "google_artifact_registry_repository" "webapp" {
    project = var.project_id
    location = var.region
    respoitory_id = var.respoitory_id
    format = "DOCKER"
    description = "Docker images for hte devops webapp"

    depends_on = [google_project_service.artifact_registry]
}