#!/bin/bash
##############
# SHOW LOGOS #
##############
clear
# Update and Upgrade install needed packages
sudo apt update -y && sudo apt upgrade -y
sudo apt install gcc curl make -y
clear
curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/Logo.sh | bash
#######################
# START SETUP TOOLING #
#######################
#Loading variables locally to current session while ignoring commented out lines and allowing spaces
# grep -v  will find lines starting with # then invert the sense of matching, to select non-matching lines.
#.env is the file with the variables
#finally xargs -d splits the process and reads
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo ${__dir}
export $(grep -v '^#' ${__dir}/secret | xargs -d '\n') >/dev/null
#export $(grep -v '^#' /home/docker/Master-Server-Setup/secret | xargs -d '\n') >/dev/null
mkdir /home/$USER/bin/ >/dev/null
mkdir /home/$USER/bin/defaults >/dev/null
# Postfix for Email notifications
    #check to see if postfix is installed
    if $(command -v postfix >/dev/null); then
        echo 'Postfix is already installed'
        echo 'Do you wish to config this program?'
            read -p 'Do you wish to config this program?' yn
            case $yn in
            [Yy]*) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/Postfix.sh | bash ;;
            [Nn]*) echo "Moving on" ;;
            *) echo 'Please answer yes or no.' ;;
            esac
    else
        echo 'Installing Postfix'
        sudo echo "postfix postfix/mailname string $FQDN" | debconf-set-selections
        sudo echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
        sudo apt-get install libsasl2-modules mailutils postfix -y
        #call postfix config script
        curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/Postfix.sh  | bash
        echo 'Postfix is now installed and setup'
    fi
#  Git
    #check to see if Git is installed
    if $(command -v git >/dev/null); then
        echo 'git is already installed'
            read -p 'Do you wish to config git?' yn
            case $yn in
            [Yy]*) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/git.sh  | bash ;;
            [Nn]*) echo "Moving on" ;;
            *) echo 'Please answer yes or no.' ;;
            esac
    else
        echo 'Installing git'
        sudo apt install git -y
        #Call Git config script
        curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/git.sh  | bash
        echo 'git is now installed and setup'
    fi
# Install and config ZSH
    if $(command -v zsh >/dev/null); then
        echo 'zsh is already installed'
            read -p 'Do you wish to config zsh?' yn
            case $yn in
            [Yy]*) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/zsh.sh  | bash ;;
            [Nn]*) echo "Moving on"   ;;
            *) echo 'Please answer yes or no.' ;;
            esac
    else
        echo 'Installing zsh'
        sudo apt install zsh -y
        curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/zsh.sh  | bash
        echo 'zsh is now installed and setup'
    fi
# ssh
    if $(command -v ssh >/dev/null); then
        echo 'ssh is already installed'
            read -p 'Do you wish to config ssh?' yn
            case $yn in
            [Yy]*) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/ssh.sh  | bash ;;
            [Nn]*) echo "Moving on"   ;;
            *) echo 'Please answer yes or no.' ;;
            esac
    else
        echo 'Installing ssh'
        #Call ssh config script
        echo 'ssh is now installed and setup'
        curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/ssh.sh  | bash
    fi
# Mergerfs
    if $(command -v mergerfs >/dev/null); then
        echo 'mergerfs is already installed'
            read -p 'Do you wish to config mergerfs?' yn
            case $yn in
            [Yy]*) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/mergerfs.sh  | bash ;;
            [Nn]*) echo "Moving on"   ;;
            *) echo 'Please answer yes or no.' ;;
            esac
    else
        echo 'Installing mergerfs'
        #Call mergerfs config script
        sudo apt install fuse
        sudo wget https://github.com/trapexit/mergerfs/releases/download/$MFSver/mergerfs_$MFSver.$OSver.deb -P /home/$USER/bin/
        sudo dpkg -i /home/$USER/bin/mergerfs_$MFSver.$OSver.deb
        curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/mergerfs.sh  | bash
        echo 'mergerfs is now installed and setup'
    fi
#Snapraid
    if $(command -v snapraid >/dev/null); then
        echo 'snapraid is already installed'
            read -p 'Do you wish to config snapraid?' yn
            case $yn in
            [Yy]*) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/snapraid.sh  | bash ;;
            [Nn]*) echo "Moving on"   ;;
            *) echo 'Please answer yes or no.' ;;
            esac
    else
        ## https://www.havetheknowhow.com/Configure-the-server/Install-SnapRAID.html 
        echo 'Installing snapraid'
        sudo mkdir /var/lib/snapraid
        sudo chmod a+w /var/lib/snapraid
        cd /var/lib/snapraid
        wget https://github.com/amadvance/snapraid/releases/download/v$SRver/snapraid-$SRver.tar.gz
        tar -xzf snapraid-$SRver.tar.gz
        cd snapraid-$SRver
        ./configure
        make
        make check
        sudo make install
        cd .. && rm /var/lib/snapraid/snapraid-11.5.tar.gz
        #Call snapraid config script
        curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/snapraid.sh  | bash
        echo 'snapraid is now installed and setup'
    fi
    #snapraid runner https://github.com/Chronial/snapraid-runner
# Log Watch
    if $(command -v Logwatch >/dev/null); then
        echo 'Logwatch is already installed'
            read -p 'Do you wish to config Logwatch?' yn
            case $yn in
            [Yy]*) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/Logwatch.sh  | bash ;;
            [Nn]*) echo "Moving on"   ;;
            *) echo 'Please answer yes or no.' ;;
            esac
    else
        echo 'Installing Logwatch'
        sudo apt install logwatch
        #Call Logwatch config script
        curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/Logwatch.sh | bash
        echo 'Logwatch is now installed and setup'
    fi
# Docker
    if $(command -v docker >/dev/null); then 
        echo 'Docker is already installed'
        else
        echo 'Installing Docker'
    #Call Docker install script
        curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/docker.sh  | bash
        echo 'Docker is now installed'
    fi 
#Auto Update with email notification

#removes variables from shell
    unset $(grep -v '^#' ${__dir}/secret | sed -E 's/(.*)=.*/\1/' | xargs)
