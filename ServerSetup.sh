##############
# SHOW LOGOS #
##############
cd ~
clear
curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/Logo.sh | bash
#######################
# START SETUP TOOLING #
#######################

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
if $(command -v postfix >dev/null)
    then 
        echo "Postfix is already installed"
        echo "Do you wish to install this program?"
        while true; do
            read -p "Do you wish to config this program?" yn
            case $yn in
                [Yy]* ) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/Postfix.sh | bash; break;;
                [Nn]* ) exit;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    else echo "Installing Postfix"
sudo apt-get install libsasl2-modules mailutils postfix -y
#call postfix config script
curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/Postfix.sh | bash
echo "Postfix is now installed and setup"
fi 

# install and config git

#check to see if Git is installed
if $(command -v git >dev/null)
    then 
        echo "git is already installed"
        echo "Do you wish to install git?"
        while true; do
            read -p "Do you wish to config git?" yn
            case $yn in
                [Yy]* ) curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/git.sh | bash; break;;
                [Nn]* ) exit;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    else echo "Installing git"
sudo apt install git -y
#Call Git config script
curl --silent -o- https://raw.githubusercontent.com/IArentBen/Master-Server-Setup/main/git.sh | bash
echo "git is now installed and setup"
fi 


# Auto Update with email notification

# Install and config ZSH

# ssh

# Snapraid

# Mergerfs

# Log Watch

# Docker and Docker-Compose

#curl --silent -o-  | bash
#curl --silent -o-  | zsh
#removes variables from shell
unset $(grep -v '^#' $OLDPWD/secret | sed -E 's/(.*)=.*/\1/' | xargs)
