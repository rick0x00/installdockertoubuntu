#!/usr/bin/env bash

cd ~

install_docker_engine(){
    echo "Install Docker Engine"
    echo "Uninstall old versions"
    sudo apt-get remove docker docker-engine docker.io containerd runc

    echo "Set up the repository"
    sudo apt update
    sudo apt install ca-certificates curl gnupg lsb-release

    echo "Add Docker Oficial GPG remote key"
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    echo "Install Docker Engine"
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

    echo "Verify that Docker Engine is installed correctly by running the hello-world image"
    sudo docker run hello-world
    echo "Verify that Docker Engine is installed correctly by running the hello-world image"
    read

    echo "Post-installation steps for Linux"
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker 
    echo "Verify that Docker Engine is installed correctly by running the hello-world image"
    docker run hello-world
    echo "Verify that Docker Engine is installed correctly by running the hello-world image"
    read

    echo "Configure Docker to start on boot"
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
}

install_docker_compose(){
    echo "Installing Compose on Linux systems"
    sudo apt-get update
    sudo apt-get install docker-compose-plugin
    echo "Verify that Docker Compose"
    docker compose version
    echo "Verify that Docker Compose"
}

install_docker_desktop(){

    sudo usermod -aG kvm $USER

    echo "unistall Docker Desktop"
    sudo apt renove docker-desktop

    rm -r $HOME/.docker/desktop
    sudo rm /usr/local/bin/com.docker.cli
    sudo apt purge docker-desktop

    echo "Install docker Desktop"
    wget https://desktop.docker.com/linux/main/amd64/docker-desktop-4.11.0-amd64.deb
    
    sudo apt-get install ./docker-desktop*.deb

    rm ./docker-desktop*.deb 

    echo "check the versions of these binaries"
    docker compose version
    docker --version
    docker version
    echo "check the versions of these binaries"
    read

    echo " enable Docker Desktop to start on login"
    systemctl --user enable docker-desktop

}

install_docker_engine;
install_docker_compose;
install_docker_desktop;

