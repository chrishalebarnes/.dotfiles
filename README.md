Dotfiles
========

Inglorious dotfile configuration.


![a terminal prompt using .dotfiles.](https://raw.githubusercontent.com/chrishalebarnes/.dotfiles/master/prompt.png?raw=true)

## Installation
Clone into `~/.dotfiles`
```
git clone git@github.com:chrishalebarnes/.dotfiles.git ~/.dotfiles
```

## Setup
Run the setup script to add the dotfiles sources.
```
~/.dotfiles/setup.sh
```

**Note**: As determined by `$OSTYPE`, Darwin (macOS) based systems will use `~/.bash_profile` while all other systems will use `~/.bashrc`.

### Plugins
Plugins have a single entry point that can be sourced called `exports.sh`. Any functions included in a plugin should be prefixed with `__<plugin-name>_`. Each active plugin is sourced from `sources/plugins.sh`

### Configurations
Configurations are sourceable files named after the `$OSTYPE`. There can also be other files like `common.sh` that any `$OSTYPE` configuration can source.

### Dotfiles
Other dotfiles can be stored in `.configurations/$OSTYPE/.<filename>`. These files should have the same name as the dotfile would in the home directory. These files get symlinked upon running `setup.sh`. Files in `.configurations` will be symlinked regardless of the platform.

### Sources
`sources` contains various files that can be sourced. `plugins.sh` specifically contains all of the plugins to be sourced.
