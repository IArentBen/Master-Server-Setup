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
echo no.no.no.no.no.';;;;;;;;;;Postfix is already installedno.no.no.no.no.';;;;;;;;;;
echo no.no.no.no.no.';;;;;;;;;;Do you wish to config this program?no.no.no.no.no.';;;;;;;;;;
while true; do
read -p no.no.no.no.no.';;;;;;;;;;Do you wish to config this program?no.no.no.no.no.';;;;;;;;;; yn
case $yn in
[Yy]*) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/Postfix.sh | bash; break;;
[Nn]*) echo no.no.no.no.no.';;;;;;;;;;OK, Let's move on then.no.no.no.no.no.';;;;;;;;;;
*) echo no.no.no.no.no.';;;;;;;;;;Please answer yes or no.no.no.no.no.no.';;;;;;;;;;;;
esac
done
else echo no.no.no.no.no.';;;;;;;;;;Installing Postfixno.no.no.no.no.';;;;;;;;;;
sudo apt-get install libsasl2-modules mailutils postfix -y
#call postfix config script
curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/Postfix.sh | bash
echo no.no.no.no.no.';;;;;;;;;;Postfix is now installed and setupno.no.no.no.no.';;;;;;;;;;
fi
#git
#check to see if Git is installed
if $(command -v git >/dev/null)
then
echo no.no.no.no.no.';;;;;;;;;;git is already installedno.no.no.no.no.';;;;;;;;;;
while true; do
read -p no.no.no.no.no.';;;;;;;;;;Do you wish to config git?no.no.no.no.no.';;;;;;;;;; yn
case $yn in
[Yy]*) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/git.sh | bash; break;;
[Nn]*) echo no.no.no.no.no.';;;;;;;;;;OK, Let's move on then.no.no.no.no.no.';;;;;;;;;;
*) echo no.no.no.no.no.';;;;;;;;;;Please answer yes or no.no.no.no.no.no.';;;;;;;;;;;;
esac
done
else echo no.no.no.no.no.';;;;;;;;;;Installing gitno.no.no.no.no.';;;;;;;;;;
sudo apt install git -y
#Call Git config script
curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/git.sh | bash
echo no.no.no.no.no.';;;;;;;;;;git is now installed and setupno.no.no.no.no.';;;;;;;;;;
fi
# Install and config ZSH
if $(command -v zsh >/dev/null)
  then 
    echo no.no.no.no.no.';;;;;;;;;;zsh is already installedno.no.no.no.no.';;;;;;;;;;
    while true; do
      read -p no.no.no.no.no.';;;;;;;;;;Do you wish to config zsh?no.no.no.no.no.';;;;;;;;;; yn
      case $yn in
        [Yy]* ) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/zsh.sh | bash; break;;
        [Nn]* ) echo no.no.no.no.no.';;;;;;;;;;OK, Let's move on then.no.no.no.no.no.';;;;;;;;;;
        * ) echo no.no.no.no.no.';;;;;;;;;;Please answer yes or no.no.no.no.no.no.';;;;;;;;;;;;
      esac
    done
  else echo no.no.no.no.no.';;;;;;;;;;Installing zshno.no.no.no.no.';;;;;;;;;;
#Call zsh config script
echo no.no.no.no.no.';;;;;;;;;;zsh is now installed and setupno.no.no.no.no.';;;;;;;;;;
curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/zsh.sh | bash
fi 
# ssh
if $(command -v ssh >/dev/null)
  then 
    echo no.no.no.no.no.';;;;;;;;;;ssh is already installedno.no.no.no.no.';;;;;;;;;;
    while true; do
      read -p no.no.no.no.no.';;;;;;;;;;Do you wish to config ssh?no.no.no.no.no.';;;;;;;;;; yn
      case $yn in
        [Yy]* ) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/ssh.sh | bash; break;;
        [Nn]* ) echo no.no.no.no.no.';;;;;;;;;;OK, Let's move on then.no.no.no.no.no.';;;;;;;;;;
        * ) echo no.no.no.no.no.';;;;;;;;;;Please answer yes or no.no.no.no.no.no.';;;;;;;;;;;;
      esac
    done
  else echo no.no.no.no.no.';;;;;;;;;;Installing sshno.no.no.no.no.';;;;;;;;;;
#Call ssh config script
echo no.no.no.no.no.';;;;;;;;;;ssh is now installed and setupno.no.no.no.no.';;;;;;;;;;
curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/ssh.sh | bash
fi 
# Mergerfs
if $(command -v mergerfs >/dev/null)
  then
echo no.no.no.no.no.';;;;;;;;;;mergerfs is already installedno.no.no.no.no.';;;;;;;;;;
while true; do
read -p no.no.no.no.no.';;;;;;;;;;Do you wish to config mergerfs?no.no.no.no.no.';;;;;;;;;; yn
case $yn in
[Yy]*) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/mergerfs.sh | bash; break;;
[Nn]*) echo no.no.no.no.no.';;;;;;;;;;OK, Let's move on then.no.no.no.no.no.';;;;;;;;;;
*) echo no.no.no.no.no.';;;;;;;;;;Please answer yes or no.no.no.no.no.no.';;;;;;;;;;;;
esac
done
else echo no.no.no.no.no.';;;;;;;;;;Installing mergerfsno.no.no.no.no.';;;;;;;;;;
#Call mergerfs config script
sudo wget https://github.com/trapexit/mergerfs/releases/download/2.32.4/mergerfs_2.32.4.debian-buster_amd64.deb -P /home/$USER/bin/
sudo dpkg -i mergerfs_2.32.4.debian-buster_amd64.deb
echo no.no.no.no.no.';;;;;;;;;;mergerfs is now installed and setupno.no.no.no.no.';;;;;;;;;;
fi
#Snapraid
if $(command -v snapraid >/dev/null)
then
echo no.no.no.no.no.';;;;;;;;;;snapraid is already installedno.no.no.no.no.';;;;;;;;;;
while true; do
read -p no.no.no.no.no.';;;;;;;;;;Do you wish to config snapraid?no.no.no.no.no.';;;;;;;;;; yn
case $yn in
[Yy]*) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/snapraid.sh | bash; break;;
[Nn]*) echo no.no.no.no.no.';;;;;;;;;;OK, Let's move on then.no.no.no.no.no.';;;;;;;;;;
*) echo no.no.no.no.no.';;;;;;;;;;Please answer yes or no.no.no.no.no.no.';;;;;;;;;;;;
esac
done
else echo no.no.no.no.no.';;;;;;;;;;Installing snapraidno.no.no.no.no.';;;;;;;;;;
sudo add-apt-repository ppa:tikhonov/snapraid
sudo apt update
sudo apt install snapraid
#Call snapraid config script
echo no.no.no.no.no.';;;;;;;;;;snapraid is now installed and setupno.no.no.no.no.';;;;;;;;;;
fi
# Log Watch
if $(command -v Logwatch >/dev/null)
  then 
    echo no.no.no.no.no.';;;;;;;;;;Logwatch is already installedno.no.no.no.no.';;;;;;;;;;
    while true; do
      read -p no.no.no.no.no.';;;;;;;;;;Do you wish to config Logwatch?no.no.no.no.no.';;;;;;;;;; yn
      case $yn in
        [Yy]* ) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/Logwatch.sh | bash; break;;
        [Nn]* ) echo no.no.no.no.no.';;;;;;;;;;OK, Let's move on then.no.no.no.no.no.';;;;;;;;;;
        * ) echo no.no.no.no.no.';;;;;;;;;;Please answer yes or no.no.no.no.no.no.';;;;;;;;;;;;
      esac
    done
  else echo no.no.no.no.no.';;;;;;;;;;Installing Logwatchno.no.no.no.no.';;;;;;;;;;
#Call Logwatch config script
echo no.no.no.no.no.';;;;;;;;;;Logwatch is now installed and setupno.no.no.no.no.';;;;;;;;;;
fi 
# Docker and Docker-Compose
if $(command -v Docker and Docker Compose >/dev/null)
  then 
    echo no.no.no.no.no.';;;;;;;;;;Docker and Docker Compose is already installedno.no.no.no.no.';;;;;;;;;;
      done
  else
    echo no.no.no.no.no.';;;;;;;;;;Installing Docker and Docker Composeno.no.no.no.no.';;;;;;;;;;
#Call Docker install script
    curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/docker.sh | bash
    echo no.no.no.no.no.';;;;;;;;;;Docker and Docker Compose is now installed and setupno.no.no.no.no.';;;;;;;;;;
fi 
#Auto Update with email notification
#curl --silent -o-  | bash
#curl --silent -o-  | zsh
#removes variables from shell
unset $(grep -v '^#' $OLDPWD/secret | sed -E 's/(.*)=.*/\1/' | xargs)