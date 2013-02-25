
umask -S u=rwx,g=rx,o= >/dev/null

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

[ "x$BASHRC_ALREADY_CONFIGURED" = "xyes" ] && return
export BASHRC_ALREADY_CONFIGURED="yes"

# Sometimes this is needed for UTF to work
export LC_CTYPE="en_US.UTF-8"

############ Local
# .bashrc.merkur.d/alias
# .bashrc.merkur.d/path

export BASHRC_HOST_CONFIG=$(uname -n|sed -e's/[.].*$//')
LOCAL_BASHRC_PREFIX=~/.bashrc.${BASHRC_HOST_CONFIG}.d
COMMON_BASHRC_PREFIX=~/.bashrc.common.d

function include()
 {
     path=$1

     local COMMON=${COMMON_BASHRC_PREFIX}/${path}
     if [ -e  ${COMMON} ]
     then
         . ${COMMON}
#     else
#         echo Skipping ${COMMON}
     fi

     local LOCAL=${LOCAL_BASHRC_PREFIX}/${path}
     if [ -e ${LOCAL} ]
     then
         . ${LOCAL}
#     else
#         echo Skipping ${LOCAL}
     fi
 }

# don't put duplicate lines in the history. See bash(1) for more option
# export HISTCONTROL=ignoredup
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# colors must be included before main
include "colors"

include "main"
include "path"
include "alias"
include "exports"

include "bashprompt"

include "screen"


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
