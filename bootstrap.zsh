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
        rsync -av --no-perms \
                --exclude ".git/" --exclude ".gitignore" \
                --exclude "etc/" \
                 .vim .vimrc .zshrc .oh-my-zsh \
                 .curlrc .functions .inputrc .wgetrc \
                 .gitconfig .gitattributes ~

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
    echo "Maxrelax RasPi - Common Apps"
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
    sudo apt-get -y dist-upgrade
    sudo apt-get -y upgrade
    sudo apt-get install -y linux-headers-$(uname -r)
    sudo apt-get install -y build-essential mlocate node npm python ruby virtualenvwrapper git
    sudo apt-get install -y alsa-source libalsaplayer-dev libao-common libao-dev libasound2 libavahi-common-dev libavahi-client-dev avahi-daemon autoconf libtool libdaemon-dev libasound2-dev libpopt-dev libssl-dev libsslcommon2-dev

    hr


    # Squeezebox setup
    # sudo apt-get install libjpeg8 libpng12-0 libgif4 libexif12 libswscale2 libavcodec53
    # sudo apt-get install -y libflac-dev libfaad2

    # echo "+ Deliberately skipping install of Squeezebox Server 7.7.3 (do this manually)"
    # Version 7.7.3 (current stable)
    # echo "+ Installing Squeezebox Server 7.7.3..."
    # wget http://downloads.slimdevices.com/LogitechMediaServer_v7.7.3/logitechmediaserver_7.7.3_all.deb
    # sudo dpkg -i logitechmediaserver_7.7.3_all.deb

    # Version 7.8.0 (might be unstable)
    # wget http://downloads.slimdevices.com/LogitechMediaServer_v7.8.0/logitechmediaserver_7.8.0_all.deb
    # sudo dpkg -i logitechmediaserver_7.8.0_all.deb

    # echo "+ Installing Squeezelite Client"
    # SQUEEZELITE_DAEMON=/usr/local/bin/squeezelite
    # wget -P /tmp http://squeezelite-downloads.googlecode.com/git/squeezelite-armv6hf
    # sudo cp $SQUEEZELITE_DAEMON /tmp/squeezelite.old
    # sudo mv /tmp/squeezelite-armv6hf $SQUEEZELITE_DAEMON
    # sudo chmod u+x $SQUEEZELITE_DAEMON

    # echo "+ Setting up Squeezelite Client to start on boot"
    # sudo cp ./etc/init.d/squeezelite /etc/init.d/squeezelite
    # sudo chmod a+x /etc/init.d/squeezelite
    # pushd /etc/init.d/
    # sudo update-rc.d squeezelite defaults
    # popd
    # SL_NAME="$(hostname -s)-Slave-Client"
    # SL_SOUNDCARD=$(${SQUEEZELITE_DAEMON} -l | grep front | tr -s ' ' | cut -d ' ' -f2)
    # [[ -n "$SL_SOUNDCARD" ]] || SL_SOUNDCARD=sysdefault
    # echo "Squeezelite client name is: '${SL_NAME}'"
    # echo "Squeezelite default soundcard is: '${SL_SOUNDCARD}'"

    echo "+ Done"
    hr
    echo "+ Finished installing common apps."
    hr
    br
}

function installShairportSync() {
    echo "Downloading shairport-sync..."
    git clone https://github.com/mikebrady/shairport-sync.git
    cd shairport-sync
    echo "Configuring shairport-sync..."
    autoreconf -i -f
    ./configure --with-alsa --with-avahi --with-ssl=openssl
    make
    echo "Installing shairport-sync..."
    sudo make install
    echo "Adding shairport-sync startup script..."
    sudo cp ../etc/init.d/shairport-sync /etc/init.d/
    sudo chmod +x /etc/init.d/shairport-sync
    echo "Adding shairport-sync to runlevel..."
    sudo update-rc.d shairport-sync defaults
    echo "Done."
}

function installDecorations() {
    # Add superfluous decorations
    echo "Maxrelax RasPi - Decorations"
    hr
    echo "+ Installing Message of the Day (MOTD)"
    br
    if [[ ! ( -a "/etc/motd.backup" ) && ( -a "/etc/motd" ) ]]; then
        echo "++ Backing up original /etc/motd -> /etc/motd.backup"
        sudo cp /etc/motd /etc/motd.backup
    fi

    echo "Copying motd files..."
    sudo cp ./etc/motd /etc/motd
    sudo cp ./etc/motd.tail /etc/
    sudo cp ./etc/motd.maxrelax /etc/
    sudo chmod 0755 /etc/motd.maxrelax

    echo "Turn off PrintLastLog in /etc/ssh/sshd_config..."
    sudo sed -i 's/PrintLastLog yes/PrintLastLog no/g' /etc/ssh/sshd_config

    echo "Add /etc/motd.maxrelax to ~/.zshrc"
    sed -i 's/\/etc\/motd.maxrelax\n//g' ~/.zshrc
    sed -i 's/\/etc\/motd.maxrelax//g' ~/.zshrc
    echo '/etc/motd.maxrelax\n' >> ~/.zshrc

    echo "Extra performance enhancements..."
    sudo apt-get remove -y wolfram-engine

    echo '+ Done'
    hr
    echo "+ I've put up the decorations!"
    hr
    br
}


if [[ "$1" == "--force" || "$1" == "-f" ]]; then
    installDotfiles
elif [[ "$1" == "--apps" || "$1" == "-a" ]]; then
    installApps
elif [[ "$1" == "--decor" || "$1" == "--decorations" || "$1" == "-d" ]]; then
    installDecorations
elif [[ "$1" == "--shairport-sync" || "$1" == "-s" ]]; then
    installShairportSync
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
unset installDecorations
unset hr
unset br
