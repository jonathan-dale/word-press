# word-press
Easy Wordpress development with Docker
Made for Ubuntu

## script.sh
use this to setup the environment and install needed packages


### Kompose

Use [kompose](https://github.com/kubernetes/kompose) to convert docker-compose files to kubernetes files
Kompose is released via GitHub on a three-week cycle, you can see all current releases on the [GitHub release page](https://github.com/kubernetes/kompose/releases).

#### Binary installation Linux and macOS:
    # Linux
    curl -L https://github.com/kubernetes/kompose/releases/download/v1.22.0/kompose-linux-amd64 -o kompose
    
    # macOS
    curl -L https://github.com/kubernetes/kompose/releases/download/v1.22.0/kompose-darwin-amd64 -o kompose
    
    chmod +x kompose
    sudo mv ./kompose /usr/local/bin/kompose



