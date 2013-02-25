
umask -S u=rwx,g=rx,o= >/dev/null

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

[ "x$BASHRC_ALREADY_CONFIGURED" = "xyes" ] && return
BASHRC_ALREADY_CONFIGURED="yes"

# Sometimes this is needed for UTF to work
export LC_CTYPE="en_US.UTF-8"


############ Local
# .bashrc.merkur.d/alias
# .bashrc.merkur.d/path

for util in . ~/.bashrc-utils.d/*
do
 . $util
done

bashrc_determine_os

export BASHRC_HOST_CONFIG=$(uname -n|sed -e's/[.].*$//')


function bashrc_debug()
{
     local -i DEBUG=0
     [[ $DEBUG -eq 1 ]] &&  echo $*
}

function include_plugin()
{
     local plugin_dir_name=$1
     local path=$2

     local COMMON_BASHRC_PREFIX=~/${plugin_dir_name}/common
     local DISTRO_BASHRC_PREFIX=~/${plugin_dir_name}/${BASHRC_OS}-${BASHRC_OS_DISTRO}


     # generic
     local COMMON=${COMMON_BASHRC_PREFIX}/${path}
     if [ -e  ${COMMON} ]
     then
         bashrc_debug include ${COMMON}
         . ${COMMON}
     fi

     # OS
     local OS_BASHRC_PREFIX=~/.bashrc.os.d/${BASHRC_OS}-common
     local OS_SPECIFIC=${OS_BASHRC_PREFIX}/${path}
     if [ -e  ${OS_SPECIFIC} ]
     then
         bashrc_debug include ${OS_SPECIFIC}
         . ${OS_SPECIFIC}
     fi

     # OS - Distro
     local OS_DISTRO_BASHRC_PREFIX=~/.bashrc.os.d/${BASHRC_OS}-${BASHRC_OS_DISTRO}
     local OS_DISTRO_SPECIFIC=${OS_DISTRO_BASHRC_PREFIX}/${path}
     if [ -e  ${OS_DISTRO_SPECIFIC} ]
     then
         bashrc_debug include ${OS_DISTRO_SPECIFIC}
         . ${OS_DISTRO_SPECIFIC}
     fi
}

function include_home()
{
     local path=$1

     # Machine
     local LOCAL_BASHRC_PREFIX=~/.bashrc.${BASHRC_HOST_CONFIG}.d
     local LOCAL=${LOCAL_BASHRC_PREFIX}/${path}
     if [ -e ${LOCAL} ]
     then
         bashrc_debug include ${LOCAL}
         . ${LOCAL}
     fi
}

function include()
{
     local plugin_dir_name=$1
     local path=$2

     include_plugin $plugin_dir_name $path
     include_home $path
}

function include_by_plugin_path()
{
  # expects e.g. ".bashrc-plugin.myplugin.d" as parameter
    local plugin_path_name=$1
    local plugin_name
    [[ $plugin_path_name =~ ^[.]bashrc-plugin[.](.*)[.]d ]];  plugin_name=${BASH_REMATCH[1]}

    bashrc_debug include_by_plugin_path: \"$plugin_path_name\" is plugin \"$plugin_name\"

    include_plugin "${plugin_path_name}" "plugin.conf"
    include_home "${plugin_name}.conf"
}

# don't put duplicate lines in the history. See bash(1) for more option
# export HISTCONTROL=ignoredup
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# colors must be included before main
include ".bashrc.os.d" "colors"

include ".bashrc.os.d" "main"
include ".bashrc.os.d" "path"
include ".bashrc.os.d" "alias"
include ".bashrc.os.d" "exports"

include ".bashrc.os.d" "bashprompt"

for plugin_name in ~/.bashrc-plugin.*.d
do
    include_by_plugin_path $(basename $plugin_name)
done

############ Shared


## RVM - Ruby Version Manager
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
if [ -d ${HOME}/.rvm/bin ]
then
 PATH=${PATH}:${HOME}/.rvm/bin # Add RVM to PATH for scripting
fi


##### Common

alias ll="ls -la"

# Colorize the Terminal

case "${COLOR_BG_IS}" in
  LIGHT)
    SOL_EMPH=${SOL_BASE01}
    SOL_BODY_TXT=${SOL_BASE00}
    SOL_COMMENT=${SOL_BASE1}
    ;;
  DARK)
    SOL_EMPH=${SOL_BASE1}
    SOL_BODY_TXT=${SOL_BASE0}
    SOL_COMMENT=${SOL_BASE01}
    ;;
    *)
    echo -e ${SOL_RED}COLOR_BG_IS should be set to 'LIGHT' or 'DARK'. Actual value : \"${COLOR_BG_IS}\"
    SOL_EMPH=${SOL_BASE1}
    SOL_BODY_TXT=${SOL_BASE0}
    SOL_COMMENT=${SOL_BASE01}
    ;;
esac

# colorize the propmt
if [ -e ~/.dir_colors ] && [ -x "$(which dircolors)" ]
then
    eval $(dircolors ~/.dir_colors)
fi
