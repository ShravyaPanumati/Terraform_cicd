steps:
# Step 1: Initialize Terraform
- name: "hashicorp/terraform"
  args: ["init"]
  dir: "terraform"

# Step 2: Apply Terraform configuration
- name: "hashicorp/terraform"
  args: [
    "apply",
    "-auto-approve",
    "-var", "project_id=$_PROJECT_ID",
    "-var", "region=$_REGION",
    "-var", "zone=$_ZONE"
  ]
  dir: "terraform"

# Step 3: Retrieve the instance name and external IP from Terraform outputs
- name: "gcr.io/cloud-builders/gcloud"
  id: "get-instance-details"
  entrypoint: "bash"
  args:
    - "-c"
    - |
      # Get the instance name and external IP using Terraform output
      INSTANCE_NAME=$(terraform -chdir=terraform output -raw instance_name)
      EXTERNAL_IP=$(terraform -chdir=terraform output -raw instance_external_ip)

      # Save the values to files
      echo $INSTANCE_NAME > instance_name.txt
      echo $EXTERNAL_IP > external_ip.txt

# Step 4: Display the application URL in build logs
- name: "gcr.io/cloud-builders/curl"
  id: "test-application"
  entrypoint: "bash"
  args:
    - "-c"
    - |
      EXTERNAL_IP=$(cat external_ip.txt)
      echo "Your application is accessible at: http://$EXTERNAL_IP"
      curl -I http://$EXTERNAL_IP

substitutions:
  _PROJECT_ID: "strategic-reef-435523-j1"
  _REGION: "us-central1"
  _ZONE: "us-central1-a"
  _BUCKET_NAME: "strategic-reef-435523-j1-static-site"

options:
  logging: CLOUD_LOGGING_ONLY
  machineType: "E2_HIGHCPU_8"
timeout: "1200s"
