#!/usr/bin/env bash
#
# Copyright 2018 - gatblau.org
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Configures the gnome terminal after the Ansible provisioning
#

echo "Performing post configuration tasks"

echo 'setting the user'
user='krypto'

echo "Granting user permission to access VBox shared folders"
sudo gpasswd --add $user vboxsf

echo "Removing the Ansible files"
sudo rm -rf /tmp/packer-provisioner-ansible-local

echo "Compacting the disk"
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY