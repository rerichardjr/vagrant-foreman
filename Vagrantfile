require "yaml"
settings = YAML.load_file "settings.yaml"

puts ""
puts ""
puts "\e[32m
  _____                                    
 |  ___|__  _ __ ___ _ __ ___   __ _ _ __  
 | |_ / _ \\| '__/ _ \\ '_ ` _ \\ / _` | '_ \\ 
 |  _| (_) | | |  __/ | | | | | (_| | | | |
 |_|  \\___/|_|  \\___|_| |_| |_|\\__,_|_| |_|
\e[0m"
puts ""
puts "\e[32m github.com/rerichardjr \e[0m"
puts ""
puts ""

SERVER_HOSTNAME = settings["server"]["hostname"]
SERVER_IP = settings["network"]["ip"]
DOMAIN = settings["network"]["domain"]
SUPPORT_USER = settings["support_user"]
BRIDGE = settings["bridge"]["device"]

Vagrant.configure("2") do |config|
  config.vm.box = settings["software"]["box"]
  if settings["bridge"]["enable"]
    config.vm.network :public_network, ip: SERVER_IP, :bridge => BRIDGE
  end
  config.vm.box_check_update = true

  config.vm.define SERVER_HOSTNAME do |host|
    host.vm.hostname = SERVER_HOSTNAME
    host.vm.provider "virtualbox" do |vb|
      vb.cpus = settings["server"]["cpu"]
      vb.memory = settings["server"]["memory"]
    end

    host.vm.provision "shell",
      name: "Configure common settings for server",
      env: {
        "SUPPORT_USER" => SUPPORT_USER,
        "DOMAIN" => DOMAIN,
        "SERVER_HOSTNAME" => SERVER_HOSTNAME,
        "SERVER_IP" => SERVER_IP,
      },
      path: "scripts/common.sh"

    host.vm.provision "shell", 
      name: "Configure Foreman",
      env: {
        "FOREMAN_VERSION" => settings["software"]["foreman"],
      },
      path: "scripts/#{host.vm.hostname}.sh"
  end
end