Homesick castle bash
====================

This is a [homesick](https://github.com/technicalpickles/homesick) _castle_ for [bash](http://www.bash.org/).

* [Solarized](http://ethanschoonover.com/solarized) color scheme
* Tailored for Linux, Solaris, and MacOS. Preliminary support for SmartOS

Exports
---------
### Common
* ```BASHRC_HOST_CONFIG``` -  The hostname used for host-specific configuration files. Defined in ```.bashrc```.
* ```BASHRC_ALREADY_CONFIGURED``` - Has ```.bashrc``` already been sourced? Set to ```yes``` if so. Defined in ```.bashrc```.

### Screen
**TODO**: Move to screen castle

* ```BASHRC_SCREEN_CONF_DIR``` - Directory for screen configurations. Defined in ```./.bashrc.common.d/screen```.
* ```BASHRC_SCREEN_CONF``` - A system (hostname) dependend screen configuration. If no system specific configuration is found: ```default.screenrc"```. Defined in ```./.bashrc.common.d/screen```.

