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
** This instruction has tested on Digital ocean kubernetes. You need to install Nginx-Ingress controller and Cert-Manager from Digital Ocean marketplace or Helmchart.

You need to verify in Cer-Manager and Nginx-ingress pod are running:

`kubectl get pods -n cert-manager`
`kubectl get pods --all-namespaces -l app.kubernetes.io/name=ingress-nginx`

Then we need to create a certificate issuer CRD in the respective namespace. You need to insert your email address into `cert-crd.yaml` and run the below command:

`kubectl create -f cert-crd.yaml`

The initial k8s config is done.

## Create Docker Image

You can use `Dockerfile` as a template to build your docker image

docker build  --platform=linux/amd64 -t new-app .
docker tag new-app:latest <Your Repo>/new-app:latest
docker push <You Repo>/new-app:latest

In order to follow-up Kubernetes best practice we will separate Namespace and ServiceAccount. We will create SSL for this deployment moreover since we only need to expose /ping api so we use path base routing method. 

## Ingress config

You need to put your URL in Ingress.yaml. 

```
 - hosts:
    - <Put your url here>
    secretName: letsencrypt-nginx
  rules:
    - host: <put your url here>
      http:
```
You also need to define a DNS A record and point your desire url to your external kuerbtenes IP address. You can find your external IP by running below command.

`kubectl get svc -n ingress-nginx`

Ready for launch?
 `cd k8s && kubectl create -f .`
