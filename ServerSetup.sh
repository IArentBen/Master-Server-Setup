##############
# SHOW LOGOS #
##############
cd ~
clear
curl --silent -o- https://github.com/IArentBen/Master-Server-Setup/blob/main/Logo.sh | bash
#######################
# START SETUP TOOLING #
#######################
# Update and Upgrade
sudo apt update -y && sudo apt upgrade -y
# config email email
# install and config git
# Auto Update with email notification
# Install and config ZSH
# ssh
# Snapraid
# Mergerfs
# Log Watch
# Docker and Docker-Compose

curl --silent -o-  | bash
curl --silent -o-  | zsh

source ~/.zshrc

##############
# NEXT STEPS #
##############
# Can I just run this?
echo "SOME THINGS TO DO..."
echo "*******************************************************"
echo "* ssh-keygen -t ed25519 -C \"your_email@example.com\" *"
echo "*******************************************************"
echo "*************************************************************"
echo "* cd ~ && git clone https://github.com/bcbrian/.scripts.git *"
echo "*************************************************************"
echo "**********************************"
echo "* open nvim and run plug install *"
echo "**********************************"
echo "***************************************"
echo "* setup nvim config file to load mine *"
echo "***************************************"




