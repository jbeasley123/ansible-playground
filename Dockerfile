############################################################
# Dockerfile to build Ansible image for Ubuntu 14.04
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

MAINTAINER Joel Beasley <joelbeasley78@gmail.com>

# Update the repository sources list
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-add-repository ppa:ansible/ansible
RUN apt-get update
RUN apt-get install -y ansible
ADD ansible /etc/ansible
RUN cat /etc/ansible/hosts
RUN ls -la /etc/ansible/roles
RUN apt-get install -y openssh-server

# Assumes SSH keys are available locally/securely
ADD ./ssh-keys /root/.ssh
