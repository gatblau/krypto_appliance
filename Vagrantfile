# script for setting up krypto user and group

$script = <<SCRIPT
echo 'adding krypto group'
groupadd -g 501 krypto

echo 'adding krypto user'
useradd krypto -u 501 -g krypto -G wheel

echo 'setting password for krypto user'
echo "krypt0"|passwd --stdin krypto

echo 'adding krypto user to the sudoer list'
echo 'krypto    ALL=(ALL)   NOPASSWD: ALL' >> /etc/sudoers.d/krypto
chmod 0440 /etc/sudoers.d/krypto
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "openssl" #"bento/centos-7.5"
  config.ssh.insert_key = false
  config.vm.provider "virtualbox" do |vbox|
    vbox.memory = 4096
    vbox.cpus = 2
    vbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vbox.customize ["modifyvm", :id, "--ioapic", "on"]
  end
  config.vm.network "private_network", ip: "192.168.50.10"
  config.vm.hostname = "krypto"
  config.vm.define :krypto do |krypto| end
  config.vm.provision "shell", inline: $script
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "build/site.yml"
    ansible.inventory_path = "build/inventory.remote"
    ansible.become = "yes"
    ansible.verbose = "vv"
    ansible.extra_vars = {
        ansible_ssh_user: 'vagrant',
        ansible_ssh_private_key_file: "~/.vagrant.d/insecure_private_key"
    }
  end
end
