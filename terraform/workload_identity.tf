
#for service account 
resource "google_service_account" "github_deployer" {
    project = var.project_id
    account_id = var.deployer_sa_id
    display_name = "Github Actions Deployer"
    description = "Identity Github Actions uses to push images and deploy to cloud run" 

    depends_on = [google_project_service.iam]
}

