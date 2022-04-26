# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
 # The most common configuration options are documented and commented below.
 # For a complete reference, please see the online documentation at
 # https://docs.vagrantup.com.

 # Every Vagrant development environment requires a box. You can search for
 # boxes at https://vagrantcloud.com/search.
 config.vm.box = "ubuntu/bionic64"
 config.vm.box_version = "~> 20200304.0.0"

 config.vm.network "forwarded_port", guest: 8000, host: 8000

 config.vm.provision "shell", inline: <<-SHELL
   systemctl disable apt-daily.service
   systemctl disable apt-daily.timer

   sudo apt-get update
   sudo apt-get -y upgrade
   sudo apt-get install -y python3-venv zip
   touch /home/vagrant/.bash_aliases
   if ! grep -q PYTHON_ALIAS_ADDED /home/vagrant/.bash_aliases; then
     echo "# PYTHON_ALIAS_ADDED" >> /home/vagrant/.bash_aliases
     echo "alias python='python3'" >> /home/vagrant/.bash_aliases
   fi
   if ! grep -q SET_O_VI_ADDED /home/vagrant/.bashrc; then
     echo "# SET_O_VI_ADDED" >> /home/vagrant/.bashrc
     echo "set -o vi" >> /home/vagrant/.bashrc
   fi

   # The following is created by Lothar S for creating and using a Virtualenv by PyCharm
   # in the Vagrant machine  (pyCharm can't do virtual env on ramote development)  LSc-04/22
   sudo --user vagrant python3 -m venv /home/vagrant/env

   touch /home/vagrant/python3-venv
   echo '#!/usr/bin/env bash'  >> /home/vagrant/python3-venv
   echo '# Shim Script fpr activating python venv before starting python' >> /home/vagrant/python3-venv
   echo '# This is because PyCharm cannot activate a venv environment on a remote server' >> /home/vagrant/python3-venv
   echo '# found at https://youtrack.jetbrains.com/issue/PY-29551/No-way-to-activate-virtualenv-for-remote-interpreter#27-4891080.0-0' >> /home/vagrant/python3-venv
   echo '' >> /home/vagrant/python3-venv
   echo 'source /home/vagrant/env/bin/activate' >> /home/vagrant/python3-venv
   echo 'exec python3 $*' >> /home/vagrant/python3-venv
   chmod +x /home/vagrant/python3-venv
   chown vagrant:vagrant /home/vagrant/python3-venv


 SHELL
end
@LscEmitter
