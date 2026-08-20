#!/usr/bin/env bash
set -euo pipefail

PROJECT_ID="devops-cicd-webapp"
REGION="asia-south1"
SERVICE_NAME="my-devops-webapp"

echo "== 1. Deleting the Cloud Run service (not tracked by Terraform) =="
gcloud run services delete "$SERVICE_NAME" \
  --project="$PROJECT_ID" \
  --region="$REGION" \
  --quiet

echo "== 2. Destroying everything Terraform created =="
echo "   (service account, WIF pool/provider, Artifact Registry repo + all images, IAM bindings)"
cd "$(dirname "$0")/terraform"
terraform destroy -var="project_id=$PROJECT_ID"

echo ""
echo "Done. The 6 APIs enabled in Step 4 remain enabled (disable_on_destroy=false,"
echo "a deliberate choice from Step 4) - this costs nothing sitting idle, but if you"
echo "want a fully bare project, disable them manually:"
echo "  gcloud services disable run.googleapis.com artifactregistry.googleapis.com \\"
echo "    iam.googleapis.com iamcredentials.googleapis.com sts.googleapis.com \\"
echo "    cloudresourcemanager.googleapis.com --project=$PROJECT_ID"
