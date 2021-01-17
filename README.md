# word-press
Easy Wordpress development with Docker (for debian/ubuntu).   
We start out with docker-compose file configured to run a word-press web site with nginx web-server and mysql DB backend.   
Next we use Kompose to convert the single docker-compose.yaml file into kubernetes manifests files (deployments, services, pv, pvc...)  

##### script.sh
Run first to setup and install needed packages
```sh
./script.sh
```

##### Install k3d's and install a cluster
```sh
wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
k3d cluster create mycluster
```


#### Create the .env file
Copy .env.template to .env and set values for the database  

Also add .env file to .gitignore so you dont commit the secrets   
```sh
cp .env.template .env
touch .gitignore
echo ".env" > .gitignore
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


##### kompose .env parsing Error

Kompose dose not currently support parsing variables from .env files, see this [issue](https://github.com/kubernetes/kompose/issues/1289) for more info.

The work around:  
```sh
docker-compose config > docker-compose.new.yaml
kompose convert -f docker-compose.new.yaml
```
