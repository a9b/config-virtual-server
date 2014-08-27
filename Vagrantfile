# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # 文字コードのエラー制御
  Encoding.default_external = 'UTF-8'

  # プロビジョニングのファイル指定
  config.vm.provision :shell, :path => "bootstrap_start.sh"

  # vagrant up 時に Chef が入っているか確認してインストールしてくれる
  # https://github.com/schisamo/vagrant-omnibus
  config.omnibus.chef_version = :latest
  #config.omnibus.chef_version = "11.4.0"

  # いろんな人が作った Cookbook を使いまわすberkshelfを有効にする
  # vagrant-berkshelfをサポートしなくなったので非推奨
  # config.berkshelf.enabled = false # インストールしていて利用しない場合は明示的にfalse
  # 代わりに直接インストールしたberkshelfを使う
  # gem install berkshelf

  # chef-solo settings
  config.vm.provision :chef_solo do |chef|
    # debug, info, warn, error, or fatal.
    chef.log_level = :info

    # サードパーティ用とプラベートの2つを相対パス指定
    # 先に定義したクックブックは後で定義したクックブックによって上書きされる
    #chef.cookbooks_path = "cookbooks"
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
    # 複数指定できない
    chef.roles_path     = "roles"
    chef.data_bags_path = "data_bags"

    # Chef-solo の attributes.json ファイル
    chef.run_list = [
      "recipe[nodejs::install_from_binary]" # バイナリインストール(redhat)
      #"recipe[nodejs::installfrompackage]" # ソースインストール(Ubuntu)
    ]
    chef.add_recipe "apache2"
    chef.add_recipe "apache2_virtualhost"
    chef.add_recipe "apache2_virtualhost::add"
    chef.add_recipe "apache2::mod_php5"
#    chef.add_recipe "mysql"
#    chef.add_recipe "mysql::client"
#    chef.add_recipe "mysql::server"
    chef.add_recipe "php"
    chef.add_recipe "vim"
#    chef.add_recipe "nginx"

     # attributesを直接上書き
#    chef.json = {
#      :apache => {
#        :default_site_enabled => true
#      },
#      :mysql => {
#        :server_root_password => "123456",
#        :server_repl_password => "123456",
#        :server_debian_password => "123456"
#      }
#    }

    # recipesの上書きをする
    #chef.json = {
    #  :apache => {
    #    :access_log => "hogehoge.log"
    #  },
    #}


    # 実行する./roles/xxx.rb
#    chef.add_role("apache_add_webserver")
#    chef.add_role("iptabele_local_rule")
  end

  config.vm.provision :shell, :path => "bootstrap_end.sh"

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  #config.vm.box = "cent_64_aqua"
  config.vm.box = "centos_64"

  #config.vm.hostname = "centos_64"
  config.vm.hostname = "a9b.local"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.

  # CentOS 6.4 x86_64 Minimal (VirtualBox Guest Additions 4.2.16, Chef 11.6.0, Puppet 3.2.3)
  config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130731.box"
  #config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-i386-v20130731.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # host(127.0.0.1)の8082番を、guest(仮想環境)の80番にポートフォワードする
  #config.vm.network :forwarded_port, guest: 80, host: 8082, auto_correct: true

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10" 

  # ホストオンリーネットワークで以下のIPアドレスを割り当てる
  config.vm.network :private_network, ip:"192.168.0.200"
  #config.vm.network :private_network, ip:"192.168.0.200", virtualbox__intnet: "intnet"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./../../../www", "/var/www/html"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # やたらネットワークが遅い現象の対策 (ipv6絡み)
  # see https://github.com/mitchellh/vagrant/issues/1172
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
  end

  # 仮想マシン自体の設定(vagrant statusで見えるマシン)
  # 単体で起動する場合
  config.vm.provider :virtualbox do |vb|
    # 仮想マシンの名前(Virtualboxのメニューに出る)
    vb.name = "vagrant_cent64"
    # メモリ => 1G
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # 複数台起動する場合
#  config.vm.define :web1 do |web1| 
#    web1.vm.hostname = "vagrant.cent64.web1" 
#    web1.vm.network :private_network, ip: "192.168.33.10" 
#    web1.vm.provider "virtualbox" do |v| 
#      v.customize ["modifyvm", :id, "--memory", 512] 
#      v.name = "web1" 
#    end 
#  end 
#  config.vm.define :web2 do |web2| 
#    web2.vm.hostname = "vagrant.cent64.web2" 
#    web2.vm.network :private_network, ip: "192.168.33.11" 
#    web2.vm.provider "virtualbox" do |v| 
#      v.customize ["modifyvm", :id, "--memory", 512] 
#      v.name = "web2" 
#    end 
#  end 

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file cent_64_aqua.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "site.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
