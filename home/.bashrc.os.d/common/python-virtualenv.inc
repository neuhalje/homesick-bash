#!/bin/bash
# vim: ft=sh:

# courtesy of http://jstarrdewar.com/blog/2012/01/22/rvm-for-python-setting-up-virtualenv-and-virtualenvwrapper-on-lion/


which virtualenv >/dev/null
if [[ 0 -eq $? ]]
    then
        for candidate in /usr/bin/virtualenvwrapper.sh /usr/local/bin/virtualenvwrapper.sh
        do
            if [ -f "$candidate" ]
            then
              export VIRTUALENVWRAPPER="$candidate"
              export HAS_VIRTUALENV=1
            fi
        done
fi

if [[ "$HAS_VIRTUALENV" -eq "1" ]]
then
    export WORKON_HOME=$HOME/Python.Virtualenvs
    mkdir $WORKON_HOME 2>/dev/null

    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    export PIP_RESPECT_VIRTUALENV=true

    # pip should only run if there is a virtualenv currently activated
    export PIP_REQUIRE_VIRTUALENV=true
    # cache pip-installed packages to avoid re-downloading
    export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
    export VIRTUALENVWRAPPER_VIRTUALENV=$(which virtualenv)

    source "$VIRTUALENVWRAPPER"

    syspip(){
        PIP_REQUIRE_VIRTUALENV="" pip "$@"
    }
    has_virtualenv() {
        if [ -e .venv ]; then
        workon `cat .venv`
        fi
    }
    venv_cd () {
        cd "$@" && has_virtualenv
    }
    alias cd="venv_cd"
fi

