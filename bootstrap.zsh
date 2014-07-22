#!/usr/bin/env zsh

function hr() {
    echo "------------------------------------------------------------"
}

function br() {
    echo ""
}

function installDotfiles() {
    PLATFORM="unknown"
    unamestr=`uname`
    if [[ "$unamestr" == 'Darwin' ]]; then
        PLATFORM='osx'
    elif [[ "$unamestr" == 'Linux' ]]; then
        PLATFORM='linux'
    elif [[ "$unamestr" == 'FreeBSD' ]]; then
        PLATFORM='freebsd'
    fi

    if [[ -z "$ZSH" ]]; then
        echo "ZSH is not set, aborting. (it is usually ~/.oh-my-zsh)"
    else

        # Git update from origin master
        br
        echo "GIT UPDATE"
        hr
        git pull origin master

        # Primary dotfiles
        br
        br
        echo "PRIMARY DOTFILES (zsh/vim/osx)"
        hr
        mkdir "$ZSH/custom" > /dev/null 2>&1
        mkdir "$ZSH/themes" > /dev/null 2>&1
        rsync -av --no-perms --exclude ".git/" --exclude ".gitignore" .vim .vimrc .osx .zshrc .oh-my-zsh ~

        br
        br
        echo "EXTRAS (~/bin)"
        hr

        if [[ "$PLATFORM" != 'osx' ]]; then # GNU coreutils `ls`
            echo "Detected OS ($PLATFORM) other than Mac OS X. Not creating or adding anything to ~/bin."
        else # OS X 'ls'
            echo "Detected OS X. Adding GNU coreutils ls, dircolors, & extras to ~/bin"
            mkdir "~/bin" > /dev/null 2>&1
            rsync -av --no-perms bin/* ~/bin/
        fi

        br
        hr
        source ~/.zshrc
        echo "Installation complete. Reloaded shell config from ~/.zshrc"
        br
    fi
}

function installApps() {
    # Add reailtime audio repository
    echo "Maxrelax Rasperry Pi Common Apps"
    hr
    echo "+ Adding rpi.autostatic.com repo to apt-get..."
    br
    wget -O - http://rpi.autostatic.com/autostatic.gpg.key| sudo apt-key add -
    sudo wget -O /etc/apt/sources.list.d/autostatic-audio-raspbian.list http://rpi.autostatic.com/autostatic-audio-raspbian.list
    echo '+ Done'
    hr
    echo "+ Updating apt-get and installing essential packages..."
    br
    sudo apt-get update
    sudo apt-get install build-essential mlocate node npm python ruby virtualenvwrapper alsa-source libalsaplayer-dev libao-common libao-dev libasound2 libasound2-dev libavahi-common-dev libavahi-client-dev libpulse-dev libasound2-plugins avahi-daemon
    echo "+ Done"
    hr
    echo "+ Finished installing common apps."
    hr
    br
}


if [[ "$1" == "--force" || "$1" == "-f" ]]; then
    installDotfiles
elif [[ "$1" == "--apps" || "$1" == "-a" ]]; then
    installApps
else
    br
    echo "Maxrelax Rasperry Pi dotfiles for ZSH"
    echo "+ More Info: https://github.com/maxrelax/raspi-dotfiles"
    echo "+ Use --apps to install common applications"
    hr
    br
    echo "This may overwrite existing files in your home directory"
    read "REPLY?and zsh/vim config directories. Are you sure? (y/n) "
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        installDotfiles
    else
        echo "Aborted installation."
    fi
fi
unset installApps
unset installDotfiles
unset hr
unset br
