# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# Default theme that ships with oh-my-zsh
ZSH_THEME="maxrelax-raspi"

# Drew's themes
#ZSH_THEME="lazyprodigy"
#ZSH_THEME="lazyprodigy-server"

DISABLE_CORRECTION="true"
# CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"

COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in  ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

plugins=(git bower node npm zsh-syntax-highlighting)
# Drew's Plugins
# plugins=(git bower coffee extract gem node npm pip python rvm virtualenv virtualenvwrapper zsh-syntax-highlighting)

# use 'default' virtualenv for python (environments live in /sites/envs)
# workon default

# Load RVM scripts if RVM is installed
if [[ -s "$HOME/.rvm/scripts/rvm" ]] then
    # echo "[Notice] Detected RVM and added ~/.rvm/bin to PATH"
    . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
fi

source $ZSH/oh-my-zsh.sh

/etc/motd.maxrelax
