CI/CD Pipeline: Node.js + Docker + GitHub Actions + Cloud Run

A small Express web app, automatically tested, containerized, and deployed to
Google Cloud Run on every push to `main` — via GitHub Actions and Terraform.

## Live demo

https://my-devops-webapp-ulniklxtsq-el.a.run.app


## Architecture

```
GitHub push (main)
  -> GitHub Actions: test job (npm ci, npm test, docker build smoke test)
  -> GitHub Actions: deploy job
       -> authenticate via Workload Identity Federation (no static keys)
       -> build + push Docker image -> Artifact Registry
       -> gcloud run deploy -> Cloud Run
  -> live HTTPS URL, auto-scaling, scales to zero when idle
```

## Stack

- **App**: Node.js 18, Express
- **Container**: Docker (`node:18-alpine`)
- **CI/CD**: GitHub Actions
- **Infra as Code**: Terraform (service account, Artifact Registry, Workload
  Identity Federation)
- **Cloud**: Google Cloud Run + Artifact Registry, region `asia-south1`
- **Auth**: Workload Identity Federation (keyless — GitHub's OIDC token is
  exchanged for a short-lived Google credential, no service account key ever
  created or stored)

## Local development

```bash
npm install
npm start          # serves on localhost:3001
```

## Run in Docker

```bash
docker build -t my-devops-webapp:local .
docker run -p 3001:3001 my-devops-webapp:local
```

## Deploy the infrastructure

Requires a GCP project with billing enabled and the `gcloud` CLI authenticated.

```bash
cd terraform
terraform init
terraform apply -var="project_id=<your-project-id>"
```

Then add the 5 values from `terraform output` as GitHub repo Variables
(Settings -> Secrets and variables -> Actions -> Variables):
`GCP_PROJECT_ID`, `GCP_REGION`, `AR_REPO_NAME`, `GCP_SA_EMAIL`, `WIF_PROVIDER`.

From there, every push to `main` deploys automatically.

## Tear it down

```bash
./cleanup.sh
```

Deletes the Cloud Run service, then destroys everything Terraform created
(service account, WIF pool/provider, Artifact Registry repo and all images).
