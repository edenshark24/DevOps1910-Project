# 🚀 Flask Hello World – CI/CD & Helm Registry (Stage 3)

## 📖 Description

This branch represents **Stage 3** of the Flask Hello World DevOps project. The application delivery is now **fully automated** using a **Jenkins CI/CD Pipeline** and managed via a **versioned Helm Chart registry**.

> ⚠️ For **manual Kubernetes instructions**, refer to **Stage 2**.

---

## ✅ Requirements

* Jenkins installed with **Docker** and **Helm** access
* Kubernetes cluster (**Minikube** or **k3s**)
* Docker Hub account (**eden2404**)
* GitHub Pages enabled for Helm repository hosting

---

## 🌊 Steps

### 1️⃣ Add the Helm Repository

```bash
helm repo add my-flask-repo https://edenshark24.github.io/DevOps1910-Project/Helm/helm-repo/
helm repo update
```

---

### 2️⃣ Run the Jenkins Pipeline

Configure a Jenkins job pointing to the provided **Jenkinsfile**.

The pipeline performs the following stages automatically:

* **Build** 🏗️
  Builds a Docker image tagged with `${BUILD_NUMBER}`

* **Test** 🧪
  Runs a temporary container and validates the application response using `curl`

* **Deploy** 🚀
  Executes `helm upgrade --install` using the newly built image tag

---

### 3️⃣ Manual Deployment (Optional)

```bash
helm upgrade --install flask-app ./Helm --set image.tag=latest
```

---

## 📦 Helm Repository Registry

This project uses **GitHub Pages** to host a **versioned Helm chart registry**.

* **Landing Page**: Served via `index.html`
* **Metadata**: Managed by `index.yaml` to track chart versions and digests

---

## 🛠 Automation Tools Used

* **Jenkinsfile**
  Multi-stage pipeline (Build, Test, Deploy) with automatic container cleanup

* **Helm Chart (v0.1.0)**
  Packages:

  * Deployment
  * Service
  * HPA
  * CronJobs

* **GitHub Pages**
  Acts as a static host for the Helm chart repository

---

## 📝 Notes

* Replace **eden2404** in `values.yaml` if using a different Docker Hub registry
* The Jenkins pipeline keeps the environment clean by removing test containers in the `post` block
* The application is exposed via **NodePort `30080`**
