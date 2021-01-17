# word-press
Easy Wordpress development with Docker
Made for Ubuntu

#### script.sh
    used to setup and install needed packages

#### Create the .env file
Copy .env.template to .env and set values for
- MYSQL_USER="string"
- MYSQL_PASSWORD="string"
- MYSQL_ROOT_PASSWORD="string"

 should add to .gitignore so you dont commit the secrets 
``sh
touch .gitignore
echo ".env" > .gitignore
``



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
