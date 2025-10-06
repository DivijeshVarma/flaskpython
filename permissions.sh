#!/bin/bash

# Define the project ID as a variable
PROJECT_ID="animated-way12" 
# Define the Service Account email as a variable (optional, but good practice)
SERVICE_ACCOUNT="986912606421-compute@developer.gserviceaccount.com"

echo "Applying IAM roles to $SERVICE_ACCOUNT on project $PROJECT_ID..."
echo "--------------------------------------------------------"

# Array of roles to be granted
ROLES=(
    "roles/appengine.appAdmin"
    "roles/appengine.deployer"
    "roles/appengine.serviceAdmin"
    "roles/cloudbuild.builds.editor"
    "roles/secretmanager.admin"
    "roles/storage.admin"
)

# Loop through the roles and apply them
for ROLE in "${ROLES[@]}"; do
    echo "Granting role: $ROLE"
    gcloud projects add-iam-policy-binding "$PROJECT_ID" \
        --member="serviceAccount:$SERVICE_ACCOUNT" \
        --role="$ROLE" \
        --condition=None
done

echo "--------------------------------------------------------"
echo "All roles have been granted to $SERVICE_ACCOUNT on project $PROJECT_ID."
