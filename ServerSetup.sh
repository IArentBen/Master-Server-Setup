##############
# SHOW LOGOS #
##############
cd ~
clear
curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/Logo.sh | bash
#######################
# START SETUP TOOLING #
#######################
mkdir /home/$USER/bin/
#Loading variables locally to current session while ignoring commented out lines and allowing spaces
# grep -v  will find lines starting with # then invert the sense of matching, to select non-matching lines.
#.env is the file with the variables
#finally xargs -d splits the process and reads
export $(grep -v '^#' $OLDPWD/secret | xargs -d '\n') >/dev/null
#export $(grep -v '^#' /home/docker/Master-Server-Setup/secret | xargs -d '\n') >/dev/null
# Update and Upgrade
sudo apt update -y && sudo apt upgrade -y
# config email
#check to see if postfix is installed
if $(command -v postfix >/dev/null)
then
echo 'Postfix is already installed'
echo 'Do you wish to config this program?'
while true; do
read -p 'Do you wish to config this program?' yn
case $yn in
[Yy]*) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/Postfix.sh | bash; break;;
[Nn]*) echo 'OK, Let's move on then.'
*) echo 'Please answer yes or no.';;
esac
done
else echo 'Installing Postfix'
sudo apt-get install libsasl2-modules mailutils postfix -y
#call postfix config script
curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/Postfix.sh | bash
echo 'Postfix is now installed and setup'
fi
#git
#check to see if Git is installed
if $(command -v git >/dev/null)
then
echo 'git is already installed'
while true; do
read -p 'Do you wish to config git?' yn
case $yn in
[Yy]*) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/git.sh | bash; break;;
[Nn]*) echo 'OK, Let's move on then.'
*) echo 'Please answer yes or no.';;
esac
done
else echo 'Installing git'
sudo apt install git -y
#Call Git config script
curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/git.sh | bash
echo 'git is now installed and setup'
fi
# Install and config ZSH
if $(command -v zsh >/dev/null)
  then 
    echo 'zsh is already installed'
    while true; do
      read -p 'Do you wish to config zsh?' yn
      case $yn in
        [Yy]* ) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/zsh.sh | bash; break;;
        [Nn]* ) echo 'OK, Let's move on then.'
        * ) echo 'Please answer yes or no.';;
      esac
    done
  else echo 'Installing zsh'
#Call zsh config script
echo 'zsh is now installed and setup'
curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/zsh.sh | bash
fi 
# ssh
if $(command -v ssh >/dev/null)
  then 
    echo 'ssh is already installed'
    while true; do
      read -p 'Do you wish to config ssh?' yn
      case $yn in
        [Yy]* ) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/ssh.sh | bash; break;;
        [Nn]* ) echo 'OK, Let's move on then.'
        * ) echo 'Please answer yes or no.';;
      esac
    done
  else echo 'Installing ssh'
#Call ssh config script
echo 'ssh is now installed and setup'
curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/ssh.sh | bash
fi 
# Mergerfs
if $(command -v mergerfs >/dev/null)
  then
echo 'mergerfs is already installed'
while true; do
read -p 'Do you wish to config mergerfs?' yn
case $yn in
[Yy]*) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/mergerfs.sh | bash; break;;
[Nn]*) echo 'OK, Let's move on then.'
*) echo 'Please answer yes or no.';;
esac
done
else echo 'Installing mergerfs'
#Call mergerfs config script
sudo wget https://github.com/trapexit/mergerfs/releases/download/2.32.4/mergerfs_2.32.4.debian-buster_amd64.deb -P /home/$USER/bin/
sudo dpkg -i mergerfs_2.32.4.debian-buster_amd64.deb
echo 'mergerfs is now installed and setup'
fi
#Snapraid
if $(command -v snapraid >/dev/null)
then
echo 'snapraid is already installed'
while true; do
read -p 'Do you wish to config snapraid?' yn
case $yn in
[Yy]*) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/snapraid.sh | bash; break;;
[Nn]*) echo 'OK, Let's move on then.'
*) echo 'Please answer yes or no.';;
esac
done
else echo 'Installing snapraid'
sudo add-apt-repository ppa:tikhonov/snapraid
sudo apt update
sudo apt install snapraid
#Call snapraid config script
echo 'snapraid is now installed and setup'
fi
# Log Watch
if $(command -v Logwatch >/dev/null)
  then 
    echo 'Logwatch is already installed'
    while true; do
      read -p 'Do you wish to config Logwatch?' yn
      case $yn in
        [Yy]* ) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/Logwatch.sh | bash; break;;
        [Nn]* ) echo 'OK, Let's move on then.'
        * ) echo 'Please answer yes or no.';;
      esac
    done
  else echo 'Installing Logwatch'
#Call Logwatch config script
echo 'Logwatch is now installed and setup'
fi 
# Docker and Docker-Compose
if $(command -v Docker and Docker Compose >/dev/null)
  then 
    echo 'Docker and Docker Compose is already installed'
      done
  else
    echo 'Installing Docker and Docker Compose'
#Call Docker install script
    curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/docker.sh | bash
    echo 'Docker and Docker Compose is now installed and setup'
fi 
#Auto Update with email notification
#curl --silent -o-  | bash
#curl --silent -o-  | zsh
#removes variables from shell
unset $(grep -v '^#' $OLDPWD/secret | sed -E 's/(.*)=.*/\1/' | xargs)