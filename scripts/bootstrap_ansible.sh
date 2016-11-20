#!/bin/bash

set -e

echo "Installing Ansible..."
yum install -y epel-release
yum update -y
yum install -y  ansible
yum clean all
cp /vagrant/ansible/ansible.cfg /etc/ansible/ansible.cfg
