#===============================================================
#
# .profile || .bash_profile
#
# ALIASES AND FUNCTIONS
#
#===============================================================

#-------------------
# Detect OS
#-------------------

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='mac'
elif [[ "$unamestr" == 'MINGW32_NT-6.1' ]]; then
   platform='windows'
fi

#-------------------
# Git Completion
#-------------------

## The default for Git Bash on Windows
export PS1='\[\033]0;$MSYSTEM:${PWD//[^[:ascii:]]/?}\007\]\n\[\033[32m\]\u@\h \[\033[33m\]\w$(__git_ps1)\[\033[0m\]\n$ '
if [[ $platform == 'linux' ]]; then
  #source /etc/bash_completion.d/git
  export PS1='\[\e]0;\w\a\]\n\[\e[0m\][\[\e[36m\]\t \[\e[32m\]\u \[\e[33m\]\w\[\e[32m\]$(__git_ps1 " (%s)")\[\e[0m\]]$ '
elif [[ $platform == 'mac' ]]; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
    export PS1='\[\e]0;\w\a\]\n\[\e[0m\][\[\e[36m\]\t \[\e[32m\]\u \[\e[33m\]\w\[\e[32m\]$(__git_ps1 " (%s)")\[\e[0m\]]\n$ '
  fi
#elif [[ $platform == 'windows' ]]; then
  #export PS1='\[\033]0;$MSYSTEM:${PWD//[^[:ascii:]]/?}\007\]\n\[\033[32m\]\u@\h \[\033[33m\]\w$(__git_ps1)\[\033[0m\]\n$ '
fi

if [[ $platform == 'mac' ]]; then
  export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
  export PATH=/usr/local/sbin:/usr/local/bin:$PATH:~/bin
  export COMMAND_MODE=unix2003
elif [[ $platform == 'linux' ]]; then
  export PATH=$PATH:~/bin:~/Dropbox/VHT/Git
fi

#-------------------
# Enviro Vars
#-------------------

export EDITOR=vim

#-------------------
# Personnal Aliases
#-------------------

alias h='history'
alias which='type -a'
alias ..='cd ..'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias du='du -kh'       # Makes a more readable output.
alias df='df -kTh'
alias ff='find . -name'
alias psx='ps aux | grep'
alias stop="kill -9"

if [[ $platform == 'mac' ]]; then
  alias ls='ls -G'
elif [[ $platform == 'linux' ]]; then
  alias ls='ls --color=auto'
else
  alias ls='ls --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#alias clean='find . -name *.*~ -print0 | xargs -0 rm'
alias clean='find . -name *.swp -print0 | xargs -0 rm'

alias got='git' # because I keep mistyping this
alias g='git'

alias v='vagrant'
v.go() {
  vagrant up
  vagrant ssh
}

# Ruby development

alias be='bundle exec'
alias bake='bundle exec rake'
alias baked='bundle exec rdebug rake'
alias bc='bundle console'

alias cuke='bundle exec cucumber'
alias spec='bundle exec rspec -fd --color'

export JRUBY_OPTS="-J-Xms2g -J-Xmx4g -Xcext.enabled=true"
alias jr='jruby --1.9 -S'

alias yard-graph="yard graph --dependencies --empty-mixins --full | dot -T png -o diagram.png"

if [[ $platform == 'linux' ]]; then
  alias gitg='git g'
  alias gitx='git g'
  alias open='nautilus'
  alias ack='ack-grep'
fi

alias ackr='ack --type=ruby'
alias acke='ack --type=erlang'

alias harmony='node --harmony'

if [[ $platform == 'mac' ]]; then

  alias mate='open -a /Applications/TextMate.app'
  alias tower='open -a /Applications/Tower.app'
  alias gitx="open -a /Applications/GitX.app"

  alias vi="/Applications/MacVim.app/Contents/MacOS/vim"
  alias vim="/Applications/MacVim.app/Contents/MacOS/vim"

  # Haskell and PureSctipt development
  export PATH="$PATH:$HOME/.cabal/bin"
  cabal.upgrade() {
    cabal install cabal-install
    cabal.update
    cabal update
    cabal list --simple-output --installed | awk '{print $1}' | uniq | xargs -I {} cabal install {} --reinstall
  }

  # brew install apple-gcc42
  update.stuff() {
    brew update
    brew tap homebrew/versions
    brew tap homebrew/dupes
    brew upgrade
    brew prune
    gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
    rvm get stable
    gem update --system
  }

  [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

elif [[ $platform == 'linux' ]]; then

  update.stuff() {
    sudo apt-get update
    sudo apt-get upgrade
    gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
    rvm get stable
    gem update --system
  }

  alias apt="sudo apt-get"

  export PATH=$PATH:$JAVA_HOME/bin

elif [[ $platform == 'windows' ]]; then

  alias gvim='"C:\Program Files (x86)\Vim\vim74\gvim.exe" &'
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# RVM
# http://rvm.beginrescueend.com/
# http://everydayrails.com/2010/06/28/rvm-gemsets-rails3.html

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
