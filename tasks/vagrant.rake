namespace :vagrant do

  task :insecure_private_key, :key_file do |t, args|
    args.with_defaults(key_file: '~/.vagrant.d/insecure_private_key')
    sh "ssh-add #{args[:key_file]}"
  end

  desc 'Add local ssh key to the list of approved identities (default: "~/.ssh/id_rsa")'
  task 'ssh-add', :key_file do |t, args|
    args.with_defaults(key_file: '~/.ssh/id_rsa')
    sh "ssh-add -k #{args[:key_file]}"
  end
end
