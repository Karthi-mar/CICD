terraform {
    required_version = ">= 1.5.0"
    required_provider {
        google = {
            source = "hashicorp/google"
            version = "~> 5.0"
        }
    }
}

provider "google" {
    project_id = var.project_id
    region = var.region
}