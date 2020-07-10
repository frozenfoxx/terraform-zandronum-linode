#!/usr/bin/env bash

# Variables
PACKAGES='fail2ban'

# Functions

## Install
install()
{
  echo "Installing fail2ban..."
  apt-get install -y ${PACKAGES}
}

## Enable service
start()
{
  echo "Enabling the fail2ban service..."
  systemctl restart fail2ban
  systemctl enable fail2ban
}

## Display usage information
usage()
{
  echo "Usage: install_fail2ban.sh"
  echo "  Arguments:"
  echo "    -h                     display usage information"
}

# Logic

## Argument parsing
while [[ "$1" != "" ]]; do
  case $1 in
    -h | --help ) usage
                  exit 0
                  ;;
    * )           usage
                  exit 1
  esac
  shift
done

install
start
