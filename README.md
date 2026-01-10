🚀 Flask Hello World – Helm & Jenkins Automation (Stage 3)
📖 Description
This branch represents Stage 3 of the Flask Hello World DevOps project. The focus is on automating the CI/CD pipeline and managing the application as a versioned package using Helm and Jenkins. ⚠️ For manual Kubernetes instructions, refer to Stage 2.

✅ Requirements
Jenkins installed (with Docker and Pipeline plugins)

Helm 3 installed

Access to a Kubernetes cluster (Minikube or k3s)

Docker Hub account (eden2404)

🏗 Automated Pipeline (Jenkins)
The Jenkinsfile automates the following workflow:

1️⃣ Build & Test Jenkins builds the Docker image and runs a temporary container to verify the application is responsive.

Bash

docker build -t eden2404/flask-app:${BUILD_NUMBER} .
curl -f http://localhost:5000
2️⃣ Automated Deployment Jenkins uses Helm to deploy or upgrade the application, passing the unique build number to the chart.

Bash

helm upgrade --install flask-app ./Helm --set image.tag=${BUILD_NUMBER}
📦 Helm Repository
The project features a self-hosted Helm repository via GitHub Pages.

1️⃣ Add the Repository

Bash

helm repo add my-flask-repo https://edenshark24.github.io/DevOps1910-Project/Helm/helm-repo/
2️⃣ Install from Registry

Bash

helm repo update
helm install flask-app my-flask-repo/flask-app
🛠 Automation & Packaging Tools
Jenkinsfile: Defines the three stages: Build, Test (with auto-cleanup), and Deploy.

Helm Chart (v0.1.0): Standardizes the Deployment, Service, HPA, and CronJobs into a single package.

Index.yaml: Tracks chart metadata and the flask-app-0.1.0.tgz package digest.

Index.html: A custom landing page for the GitHub Pages Helm registry.

📝 Notes
Build Tags: Every deployment is uniquely tagged with the ${BUILD_NUMBER} for easy rollbacks and tracking.

Service Access: The application remains accessible via NodePort 30080 as defined in values.yaml.

Testing: The Jenkins pipeline includes a post block to ensure Docker test containers are removed after every run.
