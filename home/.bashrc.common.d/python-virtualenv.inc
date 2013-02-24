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
	export WORKON_HOME=$HOME/.virtualenvs
	source "$VIRTUALENVWRAPPER"
	export PIP_VIRTUALENV_BASE=$WORKON_HOME
	export PIP_RESPECT_VIRTUALENV=true

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

