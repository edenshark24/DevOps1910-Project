# 🚀 Flask DevOps Project – Complete Implementation

## 📖 Description

A **Flask-based application** delivered through a complete DevOps workflow — from **Docker containerization**, through **Kubernetes orchestration**, to full **CI/CD automation with Helm**.

This repository represents the **full DevOps implementation** and is structured into dedicated branches, each reflecting a stage of infrastructure maturity.

---

## 🧭 Project Stages

### 🟢 Phase 1 – Docker (`phase-1`)

Focuses on:

* Building a Docker image
* Running the application in a container
* Local execution using Docker Compose

---

### 🔵 Phase 2 – Kubernetes (`phase-2`)

Introduces:

* Kubernetes Deployment & Service
* ConfigMap-based configuration
* Horizontal Pod Autoscaler (HPA)
* Liveness & readiness probes
* CronJobs for scheduled operations

---

### 🟣 Phase 3 – CI/CD & Helm (`phase-3`)

Implements:

* CI/CD pipeline using Jenkins
* Versioned Docker image builds
* Deployment via Helm
* Rolling updates on Kubernetes

---

## ✅ Requirements

* Docker & Docker Compose (Phase 1)
* Kubernetes cluster (Minikube or k3s) (Phase 2)
* Jenkins & Helm (Phase 3)

---

## 🛠 Technologies Used

* Flask
* Docker
* Kubernetes
* Jenkins
* Helm
* GitHub
