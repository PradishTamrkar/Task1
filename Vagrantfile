Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "echo Hello"

  config.vm.define "web" do |wp|
    wp.vm.box = "ubuntu/jammy64"
    wp.vm.network "private_network", ip: "192.168.56.8"
    wp.vm.synced_folder "/home/momo/Documents/Tasks/Task1", "/vagrant-data"
    wp.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end

    wp.vm.provision "shell", inline: <<-SHELL
      bash /vagrant-data/wordpress-installation.sh
    SHELL
    
    wp.vm.provision "file", source: "wp-config.php", destination: "/srv/www/wordpress/wp-config.php"
  end

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/jammy64"
    db.vm.network "private_network", ip: "192.168.56.9"
    db.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "1"
    end

    db.vm.provision "shell", path: "database-setup.sh"
  end
end
