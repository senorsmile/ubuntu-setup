# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

nodes = [
  { :hostname => 'desktop1804',  
    :ip => '192.168.76.101', 
    :box => 'peru/ubuntu-18.04-desktop-amd64',
    :forward => '6103', 
    :ram => 8192, 
    :cpus => 4, 
#    :disk2 => {
#        :size => '50',
#        # C:\Users\user\Documents\seafile.vdi
#        # /home/user/Documents/seafile.vdi
#        # ## yes, this works on windows and linux (tested)
#        :path => File.join(Dir.home, "Documents", "seafile.vdi"), 
#    },
  },
  #{ :hostname => 'desktop2', 
  #  :ip => '192.168.75.102', 
  #  :box => 'ubuntu/xenial64',                   
  #  :forward => '5102', 
  #  :ram => 8192, 
  #  :cpus => 4,
  #  :disk2 => {
  #      :size => '50',
  #      # C:\Users\ssmiley\Documents\seafile.vdi
  #      :path => File.join(Dir.home, "Documents", "seafile.vdi"),
  #  },
  #},
]

inventory_path    = File.join(Dir.home, "inventory", "vagrant.yml")
if inventory_path.nil?
  abort("inventory_path not able to find itself")
end
puts("inventory path: " + inventory_path.to_s)
inventory_configs = YAML.load_file(inventory_path)



$script = <<-SCRIPT
  apps=(
    htop
    vim
    curl
    wget
    nmap
    tmux
    git

    build-essential

    software-properties-common 
    
    python-setuptools 
    python-pip
    python-dev 
    gcc
  )

  sudo apt-get update && \
  time sudo apt-get -y install "${apps[@]}"

  # sudo pip install ansible==2.5.3
  sudo pip install ansible==2.3.3
SCRIPT

$script_disk2 = <<-SCRIPT
  ## script to mount disk2
  lsblk | grep 50G
SCRIPT

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box] ? node[:box] : "ubuntu/trusty64"
      nodeconfig.vm.network :private_network, ip: node[:ip]
      nodeconfig.vm.network :forwarded_port, guest: 22, host: node[:forward], id: 'ssh'

      memory = node[:ram]  ? node[:ram]  : 256;
      cpus   = node[:cpus] ? node[:cpus] : 1;

      

      nodeconfig.vm.provider :virtualbox do |vb|
  ## https://gist.github.com/leifg/4713995
        if node.has_key?(:disk2)
          file_to_disk = node[:disk2][:path]
          unless File.exist?(file_to_disk)
      vb.customize ['createhd', '--filename', file_to_disk, '--size', node[:disk2][:size].to_i * 1024] # 50 GB
          end
          #vb.customize ['storageattach', :id, '--storagectl', 'SCSI', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
          vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
        end

        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "90",
          "--cpus", cpus.to_s,
          "--memory", memory.to_s,
        ]

        #vb.gui = true
        vb.gui = false

      end
    end


    if node[:hostname] == 'desktop1804'
      config.vm.provision "shell", inline: $script


      #config.vm.synced_folder ".", "/vagrant"

      #config.vm.provision "shell", path: "bootstrap.sh"
      #config.vm.provision "shell",
      #      inline: "cd /vagrant; ./run_this.sh"
      #config.vm.provision "shell", path: "run_this.sh"
      
      config.vm.provision "ansible_local" do |ansible|
        ansible.playbook = "site.yml"
        ansible.compatibility_mode = "2.0"
        ansible.install = false
        ansible.groups = {
          "ubuntu_desktops" => ["desktop1804"], 
        }
  ansible.raw_arguments = [
          "-v", 
  ]
        ansible.extra_vars = {
            #"atom_enabled" => true,
            "google_chrome_enabled" => true,

#            "seafile_enabled" => true,
#            "seafile_install_type" => "cli",
#            "seafile_senorsmile_setup_enabled" => true,
#            "seafile_user" => "vagrant",
#            "seafile_url"  => inventory_configs['seafile_url'],
#            "seafile_email" => inventory_configs['seafile_email'],
#            "seafile_email_pass" => inventory_configs['seafile_email_pass'],
#            "seafile_symlink_dirs" => inventory_configs['seafile_symlink_dirs'],
#
#            "mount_disks_enabled" => true,
#            "mount_disks_config" => {
#              "seafile_disk" => {
#                "disk":        "/dev/sdb",
#                "partition":   "/dev/sdb1",
#                "fstype":      "ext4",
#                "path":        "/mnt/seafile",
#                "user":        "vagrant",
#                "group":       "vagrant",
#              }
#            }
        }

      end
    end


    #if node[:hostname] == 'desktop1804'
    #  config.vm.provision "shell", inline: $script
    #  config.vm.synced_folder ".", "/vagrant"
    #end
  end
end



