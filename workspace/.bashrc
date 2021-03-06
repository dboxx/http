##--------------------------------------------------------------------------------##
## .bashrc
##--------------------------------------------------------------------------------##
## @author  | Artem
## @email   | artem.teleshev@gmail.com
## @site    | http://phpsw.net
## @version | 1.0.0
##--------------------------------------------------------------------------------##

##===============================================================================================
DIR="$(dirname ${BASH_SOURCE[0]})"

## Default binary directory
export BINDIR="/usr/local/bin"

## [U]ser [L]ocal [LIB]rary [HOME] directory
export UL_LIB_HOME="/usr/local/lib"

## [L]inker [D]ynamic (https://en.wikipedia.org/wiki/Environment_variable)
export LD_LIBRARY_PATH="${UL_LIB_HOME}:/usr/lib/x86_64-linux-gnu:/lib/x86_64-linux-gnu"

## Locale
#export LC_ALL="en_US.UTF-8"

## Language
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"

## Default terminal
export TERM=xterm-color
## Default editor
export EDITOR=vim;
## Default pager
export PAGER=less;
## Title for terminal (Gnome3) 
export PROMPT_COMMAND='echo -ne "\033]0;$(hostname) | $(basename ${PWD})\007"' 

## ==[ Proxy {{{ ]==
# export PROXY_TYPE="socks5"
# export PROXY_ADDR="127.0.0.1:7080"
# export PROXY="${PROXY_TYPE}://${PROXY_ADDR}"
#
# export HTTP_PROXY="${PROXY}"
# export HTTPS_PROXY="${PROXY}"
#
# export SOCKS_SERVER="${PROXY_ADDR}"
#
# export SOCKS_PROXY="${PROXY}"
# export SOCKS5_PROXY="${PROXY}"
## ==[ }}} ]==

## ==[ Proxy for GIT {{{ ]==
# git config --global http.proxy "${PROXY}"
# git config --global https.proxy "${PROXY}"
#
# git config --global --unset http.proxy
# git config --global --unset https.proxy
#
# git config --global --remove-section http
# git config --global --remove-section https
## ==[ }}} ]==

## ==[ Unset Proxy and Socks {{{ ]==
# unset HTTP_PROXY
# unset HTTPS_PROXY
#
# unset SOCKS5_PROXY
# unset SOCKS_PROXY
# unset SOCKS_SERVER
#
# unset PROXY
# unset PROXY_TYPE
# unset PROXY_ADDR
#
# env | grep "SOCKS\|PROXY"
## ==[ }}} ]==

WORKSPACE_DIR="${HOME}"
WORKSPACE_NAME="workspace"

if [ $UID == 0 ] ; then # Root
  PATH="/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin"
  PS1="\[\033[01;44m\] \A \[\033[00m\] [\u@\h] \[\033[01;36m\]\w\[\033[00m\] # "
  MYSQL_PS1="[\R:\m] \d # "
  if [ "${SUDO_USER}" != "" ] ; then
    WORKSPACE_DIR="$(getent passwd ${SUDO_USER} | cut -d: -f6)"
  fi
else
  PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
  PS1="\[\033[01;44m\] \A \[\033[00m\] [\u@\h] \[\033[01;36m\]\W\[\033[00m\] > "
  MYSQL_PS1="[\R:\m] \d > "
fi

export WORKSPACE=$(realpath "${WORKSPACE_DIR}/${WORKSPACE_NAME}")

## PS1
## \w - full path to current directory
## \W - current directory
## \u - user name
## \h - host name
## \A - time in format H:i (23:59)
export PS1

## PS1 for console MySQL client
export MYSQL_PS1

##=== [Golang] ========================================================================== {{{ ===

export GOROOT="${UL_LIB_HOME}/go"
## set PATH so it includes GO bin if it exists
if [ -d "$GOROOT/bin" ] ; then
  PATH="${GOROOT}/bin:${PATH}"
fi

if [ -d "${WORKSPACE}/go" ] ; then
  export GOPATH="${WORKSPACE}/go"

  if [ -d "${GOPATH}/bin" ] ; then
    export GOBIN="${GOPATH}/bin"
    PATH="${GOBIN}:${PATH}"
  fi
fi
##=== [/Golang] ========================================================================= }}} ===

##=== [Path] ============================================================================ {{{ ===

## set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

#PATH="./bin:$PATH"

export PATH

##=== [/Path] =========================================================================== }}} ===

##=== [Aliases] ========================================================================= {{{ ===

## include .bash_aliases
if [ -f "${DIR}/.bash_aliases" ]; then
  . "${DIR}/.bash_aliases"
fi

##=== [/Aliases] ======================================================================== }}} ===

##=== [Completion] ====================================================================== {{{ ===
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
##=== [/Completion] ===================================================================== }}} ===

##=== [Kubernetes] ====================================================================== {{{ ===

if [ ! -f ~/.kube/completion.bash.inc ]; then
  CMD_KUBECTL=$(which kubectl)
  if [ -x $CMD_KUBECTL ]; then
    mkdir -p ~/.kube
    $CMD_KUBECTL completion bash > ~/.kube/completion.bash.inc
  fi
fi

# Connect the auto-completion code for the current session
if [ -f ~/.kube/completion.bash.inc ]; then
  source ~/.kube/completion.bash.inc
fi

##=== [/Kubernetes] ===================================================================== }}} ===
