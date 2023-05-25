# Ping Pong API

## Endpoints
- /ping - Responds with {'pong'}
- /pong - Responds with {'ping'}
- /professional-ping-pong - Responds with {'pong'} 90% of the time
- /amateur-ping-pong - Responds with {'pong'} 70% of the time
- /chance-ping-pong - Responds with {'ping'} 50% of the time and {'pong'} 50% of the time

## Description
This is a simple API to test that the RapidAPI/Mashape API Proxy is working. When you access /ping, the API will return a JSON that contains "pong"

## Test Endpoints
API is live at https://rapidapi.com/user/RapidAlex/package/ping-pong

## Deployment
**This instruction has been tested on DigitalOcean Kubernetes. You need to install Nginx Ingress controller and Cert-Manager from the DigitalOcean Marketplace or Helm Chart.**

Make sure the Cert-Manager and Nginx Ingress pods are running:

```shell
kubectl get pods -n cert-manager
kubectl get pods --all-namespaces -l app.kubernetes.io/name=ingress-nginx

```

Next, create a certificate issuer CRD in the respective namespace. Insert your email address into cert-crd.yaml and run the following command:

```shell
kubectl create -f cert-crd.yaml
```

The initial Kubernetes configuration is now done.

**Create Docker Image**

You can use the provided Dockerfile as a template to build your Docker image:

```shell
docker build --platform=linux/amd64 -t new-app .
docker tag new-app:latest <YourRepo>/new-app:latest
docker push <YourRepo>/new-app:latest
```

To follow Kubernetes best practices, we will separate the Namespace and ServiceAccount. We will also create SSL for this deployment. Since we only need to expose the /ping API, we will use path-based routing.

**Ingress Configuration**

Update the URL in `Deployment.yaml` Ingress section:

```shell
- hosts:
  - <Put your URL here>
  secretName: letsencrypt-nginx
  rules:
  - host: <Put your URL here>
    http:
```

Additionally, define a DNS A record and point your desired URL to your external Kubernetes IP address. You can find your external IP by running the following command:

```shell
kubectl get svc -n ingress-nginx
```

Ready for launch? Run the following command to create the deployment:

```shell
kubectl create -f Deployment.yaml
```


