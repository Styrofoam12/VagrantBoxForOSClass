# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'vagrant/util/platform'

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = '2'

# Load files in the support directory
Dir.glob('support/**/*.rb').each {|file| load file }

CPUS = processor_count # from support

# Vagrant configuration
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.ssh.forward_agent = true unless Vagrant::Util::Platform.windows?

  # Ubuntu for development
  config.vm.define 'linux', primary: true do |cfg|

    cfg.vm.box = 'ubuntu/trusty64'

    cfg.vm.provision :shell, :path => 'scripts/common.sh'

    cfg.vm.provider 'virtualbox' do |v|
      v.name = 'Ubuntu Server 14.04'
      v.memory = 4096
      v.cpus = CPUS
    end

    # from support, not used for OS / bochs compilation
    #  copy_ssh_keys(cfg)
    #  setup_dotfiles(cfg)
  end
end
