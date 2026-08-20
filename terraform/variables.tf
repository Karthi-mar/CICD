variable "project_id"{
    description = "GCP project id"
    type = string
}

variable "region"{
    description = "The region which is being used"
    type = string
    default = "asia-south1"
}

variable "service_name" {
    description = "Name of the cloud run service"
    type =  string 
    default = "devops-webapp"
}

variable "repository_id" {
    description = "name of the artifact repository"
    type = string
    default = "webapp-images"
}   

variable "github_repo" {
    description = "owner/repo allowed to deploy via workforce identity federation"
    type = string
    default ="Karthi-mar/CICD"
}

variable "deployer_sa_id" {
    description = "Account ID for the service account github actions will act as"
    type = string 
    default = "github-actions-deployer"
}