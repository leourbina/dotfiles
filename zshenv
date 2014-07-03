eval `dircolors ~/.dircolors.db`

#------------ Aliases -----------#

alias l='ls'

# Screen
alias byobu="byobu-screen"

# Emacs
alias e="emacsclient -t"
alias ec="nohup emacsclient -c &>/dev/null"
alias vim="emacsclient -t"
alias vi="emacsclient -t"

alias chrome="google-chrome &> /dev/null"
#alias eclipse="eclipse &> /dev/null"
alias spotify="nohup spotify &> /dev/null"

# Make rm safer
alias rm="mv -t ~/.local/share/Trash/files --backup=t --verbose"

# Avoid autocorrect
alias aptitude='nocorrect aptitude'

#------------ Env ------------#

export EDITOR="emacsclient -t"

# Virtualenv wrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/code/
source /usr/local/bin/virtualenvwrapper.sh

# Java
export JAVA_HOME=/usr/lib/jvm/java-6-oracle

#Maven 3
export M2_HOME=/usr/local/apache-maven
export MAVEN_HOME=/usr/local/apache-maven
export M2=/usr/local/apache-maven/bin
export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=128M"

# Ant
export ANT_HOME=/usr/share/ant

# Hadoop
export HADOOP_HOME=/usr/local/hadoop
export HBASE_HOME=/usr/local/hbase
export HADOOP_HOME_WARN_SUPPRESS="TRUE"

unalias fs &> /dev/null
alias fs="hadoop fs"
unalias hls &> /dev/null
alias hls="fs -ls"

# Go projects
export GOPATH=$HOME/code/go:$HOME/code/learning/go/6.824

# Nosetests
export NOSE_REDNOSE=1

# Scala
export SCALA_HOME=/usr/share/java

#-------- PATH ---------------#

# Initialize PATH
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/bin/HM

# Maven 3
PATH=$PATH:/usr/local/apache-maven/bin

# Eclipse
PATH=$PATH:/usr/local/eclipse

# Android SDK
PATH=$PATH:$HOME/android-sdk-linux/platform-tools
PATH=$PATH:$HOME/android-sdk-linux/tools

# Go Lang
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
PATH=$PATH:$GOROOT/bin:$GOBIN

# EC2 API tools
PATH=$PATH:$EC2_HOME/bin

# Add Hadoop/Hbase bin/ directory to PATH
PATH=$PATH:$HADOOP_HOME/bin:$HBASE_HOME/bin

# Gocode (for Go autocomplete)
PATH=$PATH:/usr/lib/go/bin

# Todo
PATH=$PATH:/usr/local/todo/

# Processing
PATH=$PATH:/usr/local/processing

#Cabal binaries
PATH=$PATH:~/.cabal/bin

#Cabal binaries
PATH=$PATH:~/tools

# Erlang Kerl
PATH=~/.kerl/builds/r16b/release_R16B/bin:$PATH

# Heroku Toolbelt
PATH=/usr/local/heroku/bin:$PATH

# Google App Engine
PATH=$HOME/tools/google_appengine:$PATH

# Tools
PATH=$HOME/tools/bin:$PATH

# Cabal
PATH=$HOME/.cabal/bin:$PATH

# Gephi
PATH=/usr/local/gephi/bin:$PATH

#RVM
PATH=$HOME/.rvm/bin/:$PATH
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH

#-------- PYTHONPATH ---------------#

PYTHONPATH=$HOME/code/learning/python:$PYTHONPATH
export PYTHONPATH

#-------- PYTHON ALIASES -------------#
alias venv='python -m venv'
alias serve='python -m htt.server'
alias pydoc='python -m pydoc'
alias pdb='python -m ipdb'
alias pytime='python -m timeit'
alias pyprof='python -m profile'
alias jcat='python -m json.tool'
alias cal='python -m calendar'
#------------ UMASK --------------#
umask 022

#------------ FUNCTIONS --------------#
say() {if [[ "${1}" =~ -[a-z]{2} ]]; then local lang=${1#-}; local text="${*#$1}"; else local lang=${LANG%_*}; local text="$*";fi; mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}" &> /dev/null ; }

author() {git log --pretty=format:'%H' --author $1 | xargs git show }

#------------ BITSIGHT --------------#
source $HOME/.bitsight

#------------ SECRETS --------------#
source $HOME/.secrets
