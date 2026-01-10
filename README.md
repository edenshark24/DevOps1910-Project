Here is the complete, formatted README.md file for your Phase 3 branch, following the exact style, spacing, and iconography of your previous stages.

🚀 Flask Hello World – CI/CD & Helm Registry (Stage 3)
📖 Description
This branch represents Stage 3 of the Flask Hello World DevOps project. The application delivery is now fully automated using a Jenkins CI/CD Pipeline and managed via a versioned Helm Chart. ⚠️ For manual Kubernetes instructions, refer to Stage 2.

✅ Requirements
Jenkins installed with Docker and Helm access

Kubernetes cluster (Minikube or k3s)

Docker Hub account (eden2404)

GitHub Pages enabled for Helm repository hosting

🏗 Steps
1️⃣ Add the Helm Repository

Bash

helm repo add my-flask-repo https://edenshark24.github.io/DevOps1910-Project/Helm/helm-repo/
helm repo update
2️⃣ Run the Jenkins Pipeline

Configure a Jenkins job pointing to the Jenkinsfile. The pipeline will:

Build: Create an image tagged with ${BUILD_NUMBER}.

Test: Run a temporary container and verify response via curl.

Deploy: Run helm upgrade --install using the new image tag.

3️⃣ Manual Deployment (Optional)

Bash

helm upgrade --install flask-app ./Helm --set image.tag=latest
📦 Helm Repository Registry
This project uses GitHub Pages to host a versioned Helm registry.

Landing Page: Accessible via the included index.html.

Metadata: Managed by index.yaml to track chart versions and digests.

🛠 Automation Tools Used
Jenkinsfile: Multi-stage pipeline (Build, Test, Deploy) with automated container cleanup.

Helm Chart: Version 0.1.0 packaging Deployment, Service, HPA, and CronJobs.

GitHub Pages: Serves as the static host for the Helm chart repository.

📝 Notes
Replace eden2404 in values.yaml if using a different Docker Hub registry.

The Jenkins pipeline ensures the environment remains clean by removing test containers in the post block.

The application is exposed via NodePort 30080.
