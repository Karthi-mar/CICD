#For service account 
resource "google_service_account" "github_deployer" {
    project = var.project_id
    account_id = var.deployer_sa_id
    display_name = "Github Actions Deployer"
    description = "Identity Github Actions uses to push images and deploy to cloud run" 

    depends_on = [google_project_service.iam]
}

#Workload identity pool
resource "google_iam_workload_identity_pool" "github_pool" {
    project = var.project_id
    workload_identity_pool_id = "github-actions-pool"
    display_name = "GithubActions pool"
    description = "pool for Github Actions OIDC identities"

    depends_on = [google_project_service.iam, google_project_service.iamcredentials]
}

#workload identity provider
resource "google_iam_workload_identity_pool_provider" "github_provider" {
    project = var.project_id
    workload_identity_pool_id = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
    workload_identity_pool_provider_id = "github-provider"
    display_name = "Github actions provider"

    attribute_mapping = {
        "google.subject" = "assertion.sub"
        "attribute.repository" = "assertion.repository"
    }

    attribute_condition = "assertion.repository == \"${var.github_repo}\""

    oidc {
        issuer_uri = "https://token.actions.githubusercontent.com"
    }

}

resource "google_service_account_iam_member" "wif_binding" {
    service_account_id = google_service_account.github_deployer.name
    role = "roles/iam.workloadIdentityUser"
    member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/${var.github_repo}"
}
