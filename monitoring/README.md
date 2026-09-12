# Monitoring Stack

## Architecture

- **CloudWatch Container Insights** → node-level metrics (CPU, memory, disk, network)
  Provisioned automatically via Terraform EKS addon — no manual setup needed.

- **Prometheus + Grafana** → application-level metrics (request rate, latency, error rate)
  Deployed via Helm into the `monitoring` namespace.

## Install Prometheus + Grafana

```bash
helm repo add prometheus-community \
  https://prometheus-community.github.io/helm-charts
helm repo update

helm install monitoring prometheus-community/kube-prometheus-stack \
  -f monitoring/values.yaml \
  --namespace monitoring \
  --create-namespace
```

## Access Grafana

```bash
kubectl get svc -n monitoring monitoring-grafana
```

Open the EXTERNAL-IP in your browser. Login: `admin` / password from `values.yaml`

## What each tool monitors

| Metric | Tool |
|--------|------|
| Node CPU / memory / disk | CloudWatch |
| Pod resource usage | CloudWatch |
| HTTP request rate | Prometheus |
| Request latency (p50/p95/p99) | Prometheus |
| HTTP error rate (4xx, 5xx) | Prometheus |
| Custom Flask metrics | Prometheus |
