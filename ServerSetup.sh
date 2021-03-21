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
# grep -v '^#' will find lines starting with # then invert the sense of matching, to select non-matching lines.
#.env is the file with the variables
#finally xargs -d splits the process and reads
export $(grep -v '^#' .env | xargs -d '\n')

# Update and Upgrade
sudo apt update -y && sudo apt upgrade -y
# config email
echo "postfix	postfix/mailname string $FQDN" | debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
sudo apt-get install libsasl2-modules mailutils  postfix -y
#next your email and password will be added to /etc/postfix/sasl/sasl_passwd and will be hashed after

sudo sed -i '1i[smtp.gmail.com]:587 $gmailuser:$gmailpass' /etc/postfix/sasl/sasl_passwd
sudo postmap /etc/postfix/sasl/sasl_passwd
#Secure the plain text files by limiting access to the root user at root:root and 600 permission
sudo chown root:root /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
sudo chmod 0600 /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
#edit postfix main.conf to using gmail as an smtp relay

#restart postfix service
sudo systemctl restart postfix

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
unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs)