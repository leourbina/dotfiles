# Terminal
export TERM=xterm-24bit

# Z
export ZSHZ_CMD=t

# Paths
typeset -gU cdpath fpath mailpath manpath path
typeset -gUT INFOPATH infopath

# Set the list of directories that info searches for manuals.
infopath=(
  /usr/local/share/info
  /usr/share/info
  $infopath
)

# Set the list of directories that man searches for manuals.
new_manpath=(
  /usr/local/share/man
  /usr/share/man
)

for path_file in /etc/manpaths.d/*(.N); do
  new_manpath+=($(<$path_file))
done

export MANPATH=$(echo $new_manpath | tr ' ' ':')
unset path_file

# Language
if [[ -z "$LANG" ]]; then
  eval "$(locale)"
fi

# Editors
export EDITOR='emacsclient -t'
export VISUAL='emacsclient -t'
export PAGER='less'

# Browser (Default)
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

########
# Less #
########

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

##############
##  Python  ##
##############
export PYENV_ROOT="$HOME/.pyenv"

#############
##  MySQL  ## 
#############
export LDFLAGS="-L/usr/local/opt/mysql-client@5.7/lib"
export CPPFLAGS="-I/usr/local/opt/mysql-client@5.7/include"
export PKG_CONFIG_PATH="/usr/local/opt/mysql-client@5.7/lib/pkgconfig"

##########
## JAVA ##
##########
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
#export JAVA_HOME=
. "$HOME/.cargo/env"


#########
##  n  ##
#########
export N_PREFIX=${XDG_DATA_HOME:-~/.local/share}/n
export PATH=$PATH:$N_PREFIX/bin


