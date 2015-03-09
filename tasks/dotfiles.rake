require 'fileutils'

namespace :dotfiles do

  LOCAL = File.expand_path('~/')
  REPO = File.expand_path(File.join(File.dirname(__FILE__), '../shared/dotfiles'))
  DOTFILES = Dir[File.join(REPO, '.??*')].delete_if{|f| File.extname(f) =~ /\.sw?/ } << 'global.gems'

  def local_destination_for_file(file)
    file == 'global.gems' ? File.join(LOCAL, '.rvm/gemsets') : LOCAL
  end

  desc 'Update dotfiles in vagrant repo by getting from local'
  task :get do |t|
    DOTFILES.each do |file|
      sh "cp #{File.join(local_destination_for_file(file), File.basename(file))} #{REPO}"
    end
  end

  desc 'Update local dotfiles by putting from vagrant repo'
  task :put do |t|
    DOTFILES.each do |file|
      sh "cp #{File.join(REPO, File.basename(file))} #{local_destination_for_file(file)}"
    end
  end

  desc 'Synchronize all dotfiles to/from local and repo based on timestamp'
  task :sync do |t|
    DOTFILES.each do |file|
      basename = File.basename(file)
      repo = File.join(REPO, basename)
      local = File.join(local_destination_for_file(file), basename)

      case File.mtime(repo) <=> File.mtime(local)
      when -1
        FileUtils.cp(local, repo, :verbose => true)
      when 1
        FileUtils.cp(repo, local, :verbose => true)
      else
        puts "Skipping #{basename}"
      end
    end
  end

  # git tasks -- used as dependencies

  task :git_stash do |t|
    begin
      sh 'git stash'
    rescue
      # suppress
    end
  end

  task :git_commit do |t|
    begin
      sh "git add #{REPO} && git commit -m 'Updated dotfiles'"
    rescue
      # suppress
    end
  end

  task :git_stash_apply do |t|
    begin
      sh 'git stash apply'
    rescue
      # suppress
    end
  end

  # tasks that need to stash git changes
  [:put].each do |task|
    Rake::Task[task].enhance [:git_stash] do
      Rake::Task['dotfiles:git_stash_apply'].invoke
    end
  end

  # tasks that need to stash and commit git changes
  [:get, :sync].each do |task|
    Rake::Task[task].enhance [:git_stash] do
      Rake::Task['dotfiles:git_commit'].invoke
      Rake::Task['dotfiles:git_stash_apply'].invoke
    end
  end
end
