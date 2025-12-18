# 🚀 Flask Hello World – Docker Application

## 📖 Description

A minimal **Flask Hello World** application that returns **"Hello, World!"** when accessed.

This branch represents **Stage 1** of a DevOps project and focuses solely on:

* Building a Docker image
* Running the application in a container
* Local execution using Docker Compose

---

## ✅ Requirements

* Docker
* Docker Compose

---

## 🐳 Build and Run (Docker)

### Step 1: Build the Docker Image

```bash
docker build -t <your-dockerhub-username>/flask-app:latest .
```

### Step 2: Run the Container

```bash
docker run -d -p 5000:5000 <your-dockerhub-username>/flask-app:latest
```

### Step 3: Access the Application

Open your browser and navigate to:

```
http://localhost:5000
```

Expected output:

```text
Hello, World!
```

---

## 🧩 Using Docker Compose (Recommended)

```bash
docker compose up --build
```

---

## 📦 Push to Docker Hub (Optional)

```bash
docker login
docker tag <your-dockerhub-username>/flask-app:latest <your-dockerhub-username>/flask-app:latest
docker push <your-dockerhub-username>/flask-app:latest
```

---

## 📝 Notes

* Ensure port **5000** is available on your machine
* Replace `<your-dockerhub-username>` with your Docker Hub username
