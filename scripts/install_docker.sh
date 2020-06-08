#!/usr/bin/env bash

# Variables
DATA_DIR=${DATA_DIR:-'/data'}
DEBIAN_FRONTEND=noninteractive
DEPENDENCIES="apt-transport-https ca-certificates curl gnupg-agent software-properties-common"
PACKAGES="docker-ce docker-ce-cli containerd.io"
REPO_URL="https://download.docker.com/linux/ubuntu"
REPO_GPG_KEY="https://download.docker.com/linux/ubuntu/gpg"

# Functions

## Add the Docker repo
add_repo()
{
  echo "Adding repo key..."
  curl -fsSL ${REPO_GPG_KEY} | sudo apt-key add -

  echo "Adding repository..."
  sudo add-apt-repository \
   "deb [arch=amd64] ${REPO_URL} \
   $(lsb_release -cs) \
   stable"

  apt-get update
}

## Configure system user
configure_user()
{
  echo "Configuring user to run docker..."
  groupadd docker
  usermod -aG docker ${USER}
}

## Create data directory
create_data_dir()
{
  echo "Creating data directory..."
  mkdir -p ${DATA_DIR}
}

## Install Docker dependencies
install_deps()
{
  echo "Installing dependencies..."
  apt-get install -y ${DEPENDENCIES}
}

## Install Docker packages
install_docker()
{
  echo "Installing packages..."
  apt-get install -y ${PACKAGES}
}

## Update the system packages
update()
{
  echo "Upgrading system..."
  apt-get update
  apt-get upgrade -y
}

# Logic

update
install_deps
add_repo
install_docker
configure_user
create_data_dir