# Maxrelax Dotfiles for Raspberry Pi
> Note this is a WIP repo !


This dotfiles setup is specially customized for **ZSH** (oh-my-zsh) on Mac OS X. It is a near-complete port of Mathias' original BASH dotfiles but with some bonus goodies that I've customized & added. My goal is to make this ZSH dotfiles distribution widely compatible and robust yet opinionated.

## Installation

### Prerequesites: [ZSH](http://zsh.sourceforge.net/) + [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

Install [ZSH](http://zsh.sourceforge.net/) and vim via apt-get
```bash
sudo apt-get install zsh vim git
```

Upon successful install of ZSH, close the current bash shell and open up a new terminal window, which should be a new zsh shell.

Install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) via **`curl`**
```bash
curl -L http://install.ohmyz.sh | sh
```

Install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) via **`wget`**

```bash
wget --no-check-certificate http://install.ohmyz.sh -O - | sh
```


### Easy Install of Dotfiles

You can clone the repository wherever you want. (I like to keep it in `~/dev/dotfiles`. The bootstrapper script will pull in the latest version from the master branch before installing. Remember to run these commands from a *zsh shell!*

```zsh
git clone https://github.com/maxrelax/raspi-dotfiles.git dotfiles && cd dotfiles && source bootstrap.zsh
```

#### Optional Apps Install
```zsh
source bootstrap.zsh --apps
```


## Charactaristics

### ZSH Config File Locations

The most commonly scaffolded dotfiles are placed in the `$ZSH/custom` directory, so that oh-my-zsh can be updated without conflict, as that directory is ignored by oh-my-zsh's repository.

* `~/.oh-my-zsh/custom/aliases.zsh`
* `~/.oh-my-zsh/custom/completions.zsh`
* `~/.oh-my-zsh/custom/exports.zsh`

To easily view this directory's contents after installation, type:

```zsh
zshdotfiles # will open a Finder window of the $ZSH/custom directory
zshconfig # will launch Atom (or $EDITOR) with all ZSH-related dotfiles opened
```

### Notable Features

#### Tons of convenience aliases and shortcut commands
Take a look at all the `aliases.zsh` and `completions.zsh` files within `$ZSH/custom` to see what goodies lie within. You can simply type `zshdotfiles` after installation to quickly take a look.

#### RVM scripts/bin support
Automatically dectects `~/.rvm/scripts/rvm` and adds `$HOME/.rvm/bin` to `PATH`.

#### npm auto-completion
Auto-completion support has been added for the node package manager, sourced from `npm completion >> ~/.oh-my-zsh/custom/completions.zsh`

#### Local user software first!
The `$PATH` export chain checks for executables in many common local installation paths first, preferring user-installed binaries.


---

### Add custom commands without creating a new fork

If `$ZSH/custom/extra.zsh` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `extra.zsh` looks something like this:

```bash
# Git credentials
# Not in the repository, to prevent people from accidentally committing under my name
export GIT_AUTHOR_NAME="Drew Lustro"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"

export GIT_AUTHOR_EMAIL="drewlustro@gmail.com"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"

```

You could also use `$ZSH/custom/extra.zsh` to override settings, functions and aliases from my dotfiles repository. It’s probably better to fork this repository instead, though.


## Contact & Feedback

| [![twitter/maxrelaxco](https://maxrelax.co/images/mr-icon.png)](http://twitter.com/maxrelaxco "@maxrelaxco on Twitter") |
|---|
| [Maxrelax](https://maxrelax.co) |


### Original Author Credit & Huge Thanks...

##### [Mathias Bynens](http://mathiasbynens.be/)
