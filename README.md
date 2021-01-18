# word-press
Easy Wordpress development with Docker (for debian/ubuntu).   
We start out with docker-compose file configured to run word-press on an nginx web-server with mysql DB backend, then use Kompose (see below) to convert the docker-compose.yaml fiel into Kubernetes manifests. 

- script.sh - sets up environment and installs necessary packages.

##### Install k3d's and create a cluster
```sh
wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
k3d cluster create mycluster
```

#### Create the .env file from .env.template, add .env to .gitgnore (dont commit secrets)
```sh
cp .env.template .env
touch .gitignore
echo ".env" > .gitignore
## now add your secrets to .env
```


### Kompose

Use [kompose](https://github.com/kubernetes/kompose) to convert docker-compose files to kubernetes files. 
Kompose is released via GitHub on a three-week cycle, you can see all current releases on the [GitHub release page](https://github.com/kubernetes/kompose/releases).

#### Binary installation Linux and macOS:
    # Linux
    curl -L https://github.com/kubernetes/kompose/releases/download/v1.22.0/kompose-linux-amd64 -o kompose
    
    # macOS
    curl -L https://github.com/kubernetes/kompose/releases/download/v1.22.0/kompose-darwin-amd64 -o kompose
    
    chmod +x kompose
    sudo mv ./kompose /usr/local/bin/kompose

#### Use kompose:
```sh
kompose convert -f /path/to/docker-compose.yaml
```


##### kompose .env parsing Error

Kompose dose not currently support parsing variables from .env files, see this [issue](https://github.com/kubernetes/kompose/issues/1289) for more info.  
Use this work around:  
```sh
docker-compose config > docker-compose.new.yaml
kompose convert -f docker-compose.new.yaml

INFO Network app-network is detected at Source, shall be converted to equivalent NetworkPolicy at Destination 
WARN Volume mount on the host "/home/desktop/tmp/word-press/nginx-conf" isn't supported - ignoring path on the host 
INFO Network app-network is detected at Source, shall be converted to equivalent NetworkPolicy at Destination 
INFO Network app-network is detected at Source, shall be converted to equivalent NetworkPolicy at Destination 
INFO Kubernetes file "webserver-service.yaml" created 
INFO Kubernetes file "certbot-deployment.yaml" created 
INFO Kubernetes file "certbot-etc-persistentvolumeclaim.yaml" created 
INFO Kubernetes file "wordpress-persistentvolumeclaim.yaml" created 
INFO Kubernetes file "db-deployment.yaml" created 
INFO Kubernetes file "dbdata-persistentvolumeclaim.yaml" created 
INFO Kubernetes file "app-network-networkpolicy.yaml" created 
INFO Kubernetes file "webserver-deployment.yaml" created 
INFO Kubernetes file "webserver-claim1-persistentvolumeclaim.yaml" created 
INFO Kubernetes file "wordpress-deployment.yaml" created

mkdir k8s
mv ./* ./k8s
mv ./k8s/docker-compose.new.yaml ./
kubectl apply -f k8s/
networkpolicy.networking.k8s.io/app-network configured
deployment.apps/certbot created
persistentvolumeclaim/certbot-etc created
deployment.apps/db created
persistentvolumeclaim/dbdata configured
persistentvolumeclaim/webserver-claim1 configured
deployment.apps/webserver created
service/webserver created
deployment.apps/wordpress created
persistentvolumeclaim/wordpress configured
 
```



