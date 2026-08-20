resource "google_project_service" "artifact_registry" {
    project = var.project_id
    service = "artifactregistry.googleapis.com"
    disable_on_destroy = false
}

resource "google_project_service" "run" {
    project = var.project_id
    service = "run.googleapis.com"
    disable_on_destroy = false
}


resource "google_project_service" "iam" {
    project = var.project_id
    service = "iam.googleapis.com"
    disable_on_destroy = false
}

resource "google_project_service" "iamcredentials" {
    project = var.project_id
    service = "iamcredentials.googleapis.com"
    disable_on_destroy = false
}



