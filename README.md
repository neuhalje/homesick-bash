Homesick castle bash
====================

This is a [homesick](https://github.com/technicalpickles/homesick) _castle_ for [bash](http://www.bash.org/).

* [Solarized](http://ethanschoonover.com/solarized) color scheme
* Tailored for Linux, Solaris, and MacOS. Preliminary support for SmartOS

Includes
--------

Includes are bash scripts that are sourced. First general scripts are sourced, then os specific, then distro specific, and finally hostname specific.

The order and locations of the files are:

1 ```~/.bashrc.os.d/common```
2 ```~/.bashrc.os.d/${BASHRC_OS}-common```
3 ```~/.bashrc.os.d/${BASHRC_OS}-${BASHRC_OS_DISTRO}```
4 ```~/.bashrc.${BASHRC_HOST_CONFIG}.d``` where BASHRC_HOST_CONFIG is the node name without the domain part.

The files included are, in the following order:

* ```colors```      -- *internal* create color tables

* ```main```        -- set ```COLOR_BG_IS``` to either ```DARK``` or ```LIGHT```, dpendening on whether the terminal BG is light or dark
* ```path```        -- Augement the path
* ```alias```       -- Define ```alias```es.
* ```exports```     -- Keep exports togehter

* ```bashprompt```  -- *internal* Set up the bashprompt
* ```screen```      -- *internal* see 'screen' below


Variables
---------

### Common

* ```BASHRC_HOST_CONFIG``` -  The hostname used for host-specific configuration files. Defined in ```.bashrc```. *Exported*
* ```BASHRC_ALREADY_CONFIGURED``` - Has ```.bashrc``` already been sourced? Set to ```yes``` if so. Defined in ```.bashrc```.

### OS dependend

* ```BASHRC_OS``` -- The OS running. Values for BASHRC_OS are:
     * ```aix```     -- AIX
     * ```darwin```  -- MacOS X
     * ```linux```   -- Linux
     * ```smartos``` -- joyent SmartOS
     * ```solaris``` -- Sun Solaris
     * ```windows``` -- Windows

* ```BASHRC_OS_DISTRO``` -- The distro running (only set for Linux). Values for BASHRC_OS_DISTRO are:
     * ```debian``` (also on Ubuntu)
     * ```mandrake```
     * ```redhat```
     * ```suse```

### Screen
**TODO**: Move to screen castle

* ```BASHRC_SCREEN_CONF_DIR``` - Directory for screen configurations. Defined in ```./.bashrc.common.d/screen```. *Exported*
* ```BASHRC_SCREEN_CONF``` - A system (hostname) dependend screen configuration. If no system specific configuration is found: ```default.screenrc"```. Defined in ```./.bashrc.common.d/screen```. *Exported*


Functions
----------

### Internal
* ```bashrc_determine_os``` defined in detect_os. Sets BASHRC_OS and BASHRC_OS_DISTRO.
