# 🚀 Flask Hello World – Kubernetes Deployment (Stage 2)

## 📖 Description

This branch represents **Stage 2** of the Flask Hello World DevOps project.
The application is now deployed on **Kubernetes** using Deployment, Service, ConfigMap, HPA, and CronJobs.

> ⚠️ For Docker-only instructions, refer to Stage 1.

---

## ✅ Requirements

* Minikube or k3s installed
* kubectl installed
* Docker image built and pushed to Docker Hub (replace `<your-dockerhub-username>`)

---

## 🐳 Steps

### 1️⃣ Start Minikube

```bash
minikube start
minikube addons enable metrics-server
```

### 2️⃣ Apply Kubernetes Configurations

```bash
kubectl apply -f configmap.yaml
docker apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f hpa.yaml
kubectl apply -f cronjob.yaml
```

### 3️⃣ Access the Application

```bash
minikube service flask-app-service
```

You should see **"Hello, World!"** when the app loads.

---

## 🧩 Horizontal Pod Autoscaler (HPA)

Check HPA status:

```bash
kubectl get hpa
```

Monitor scaling:

```bash
watch kubectl get hpa
```

> ⚠️ If CPU target is unknown, wait a few minutes. Metrics server must be running.

Simulate load to trigger scaling:

```bash
kubectl run -it load-tester --image=busybox --restart=Never -- /bin/sh
```

Inside the container:

```sh
while true; do wget -q -O- http://flask-app-service/load; done
```

Pods may scale up/down or crash during overload — this is expected.

---

## 🛠 Kubernetes Objects Used

* **ConfigMap**: `flask-config` (production environment, log level)
* **Deployment**: `flask-app-deployment` (3 replicas, resource limits, liveness/readiness probes)
* **Service**: `flask-app-service` (NodePort 30080)
* **HPA**: `flask-app-hpa` (CPU-based auto-scaling, 2-10 replicas)
* **CronJobs**:

  * `flask-health-check` (every 5 minutes)
  * `flask-metrics-report` (hourly)
  * `flask-log-rotation` (weekly)

---

## 📝 Notes

* Replace `<your-dockerhub-username>` in deployment.yaml with your Docker Hub username.
* Metrics server is required for HPA to work.
* CronJobs are used for health checks, metrics reporting, and log rotation.
* NodePort exposes the app at port **30080** on your local cluster.

---

