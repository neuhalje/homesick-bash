Homesick castle bash
====================

This is a [homesick](https://github.com/technicalpickles/homesick) _castle_ for [bash](http://www.bash.org/).

* [Solarized](http://ethanschoonover.com/solarized) color scheme
* Tailored for Linux, Solaris, and MacOS. Preliminary support for SmartOS

Usage
------

Use the repo with ```homesick```: 

```bash
homesick clone ssh://git@github.com:neuhalje/homesick-bash.git
homesick symlink homesick-bash
```

**My castles**: ```homesickdir``` takes you to ```~/.homesick/repos/```.

**Updating**: ```homesick_update``` automatically calls ```homesick pull``` and ```homesick symlink``` for all homesick castles in ```~/.homesick/repos/```.

**Checking for local modifications**:

```bash
$  homesick_local_changes  # also supports a -v flag
Looking for local modifications in your castles...
* homesick-bash
- there are some changed files
* homesick-git
* homesick-mail-base
- there are some untracked files
* homesick-mail-jens_home
* homesick-screen
* homesick-system-merkur
* homesick-vim
```

**Copy setup no new machine**: ```homesick_export``` prints instructions to do so, e.g.

```bash
$ homesick_export

# homesick-bash
homesick clone ssh://git@github.com:neuhalje/homesick-bash.git
homesick symlink homesick-bash

# homesick-git
homesick clone ssh://git@github.com:neuhalje/homesick-git.git
homesick symlink homesick-git

# homesick-mail-base
homesick clone ssh://git@github.com:neuhalje/homesick-mail-base.git
homesick symlink homesick-mail-base

# ...

# homesick-tmux
homesick clone ssh://git@github.com:neuhalje/homesick-tmux.git
homesick symlink homesick-tmux

# homesick-vim
homesick clone ssh://git@github.com:neuhalje/homesick-vim.git
homesick symlink homesick-vim
```



Includes
--------

Includes are bash scripts that are sourced. First general scripts are sourced, then os specific, then distro specific, and finally hostname specific.

The order and locations of the files are:

1 ```~/.bashrc.os.d/common```
2 ```~/.bashrc.os.d/${BASHRC_OS}-common```
3 ```~/.bashrc.os.d/${BASHRC_OS}-${BASHRC_OS_DISTRO}```
4 ```~/.bashrc.${BASHRC_HOST_CONFIG}.d``` where BASHRC_HOST_CONFIG is the node name without the domain part.

The files included are, in the following order:

* ```bgcolor```     -- set ```COLOR_BG_IS``` to either ```DARK``` or ```LIGHT```, dpendening on whether the terminal BG is light or dark. *Default:* ```DARK```
* ```colors```      -- *internal* create color tables
* ```main```        --~
* ```path```        -- Augement the path
* ```alias```       -- Define ```alias```es.
* ```exports```     -- Keep exports togehter

* ```bashprompt```  -- *internal* Set up the bashprompt

### Plugins
Plugins AKA other castles can hook into the sourcing lifecycle by providing a file matching the glob ```~/.bashrc-plugin.*.d```. ```.bashrc``` will source the file ```plugin.conf``` according to the rules described above.


### Example

On the system ```home``` which is an Ubuntu system, while sourcing ```.bashrc``` the following ```alias``` files are sourced in the following order (if they exist):

1 ```~/.bashrc.os.d/common/alias```
2 ```~/.bashrc.os.d/linux-common/alias```
3 ```~/.bashrc.os.d/linux-debian/alias```
4 ```~/.bashrc.home.d/alias```

If a directory ```~/.bashrc-plugin.myplugin.d``` exists, then the following files would be sourced as well (if they exist):

1 ```~/.bashrc-plugin.myplugin.d/common/plugin.conf```
2 ```~/.bashrc-plugin.myplugin.d/linux-common/plugin.conf```
3 ```~/.bashrc-plugin.myplugin.d/linux-debian/plugin.conf```
4 ```~/.bashrc.home.d/myplugin.conf```

### Debugging

Logging can be enabled in ```.bashrc``` by setting ```DEBUG=1```.


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



Functions
----------

### Internal
* ```bashrc_determine_os``` defined in detect_os. Sets BASHRC_OS and BASHRC_OS_DISTRO.


Colors
--------

To make the shell more colorfull the castle provides some color-codes that can be used in shell-scripts. For a description of the color codes see Ethan Schoonovers [Solarized page](http://ethanschoonover.com/solarized).

### Usage

```bash
 echo -e ${SOL_RED}red ${SOL_GREEN}green ${NO_COLOUR}blank ${SOL_EMPH}important ${SOL_BODY_TXT}normal ${SOL_COMMENT}unimportant
```

### Codes

The following codes exist:

**Text types**:
* ```SOL_EMPH```      - Text with emphasis, depends on the value of ```COLOR_BG_IS```.
* ```SOL_BODY_TXT```  - Normal text, depends on the value of ```COLOR_BG_IS```.
* ```SOL_COMMENT```   - Comments (lighter), depends on the value of ```COLOR_BG_IS```.
* ```NO_COLOUR```     - No color

**Colors**:
* ```SOL_YELLOW```
* ```SOL_ORANGE```
* ```SOL_RED```
* ```SOL_MAGENTA```
* ```SOL_VIOLET```
* ```SOL_BLUE```
* ```SOL_CYAN```
* ```SOL_GREEN```

**Solarized base colors** 
* ```SOL_BASE03```
* ```SOL_BASE02```
* ```SOL_BASE01```
* ```SOL_BASE00```
* ```SOL_BASE0```
* ```SOL_BASE1```
* ```SOL_BASE2```
* ```SOL_BASE3```

