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
sudo echo "postfix postfix/mailname string $FQDN" | debconf-set-selections
sudo echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
sudo apt-get install libsasl2-modules mailutils  postfix -y
#next your email and password will be added to /etc/postfix/sasl/sasl_passwd and will be hashed after
sudo touch /etc/postfix/sasl/sasl_passwd
#using this next line instead of the below line because the file is empty. Sed only works with files that contain data
echo "[smtp.gmail.com]:587 $gmailuser:$gmailpass" | sudo tee /etc/postfix/sasl/sasl_passwd > /dev/null
#sudo sed -i '1i[smtp.gmail.com]:587 $gmailuser:$gmailpass' /etc/postfix/sasl/sasl_passwd
sudo postmap /etc/postfix/sasl/sasl_passwd
#Secure the plain text files by limiting access to the root user at root:root and 600 permission
sudo chown root:root /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
sudo chmod 0600 /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
#edit postfix main.conf to using gmail as an smtp relay
#grep -q '^eat my' /etc/file sudo sed -i 's/^eat my.*/eat my ass/' /etc/file || echo 'eat my ass' >> /etc/file
#grep -q is basically an if statment of a string in a file if its true it carries on to the && portion and 
#sed -i 's/^text/ will replace the LINES containing the specified "text" with the next portion of text after the .*/ 
#the example above any line cotaining "eat my" will be replaced by "eat my ass" 
# The || or "OR" only happens when "eat my" is not found in the file and will be added to the end  
grep -q '^relayhost =' /etc/postfix/main.cf && sudo sed -i 's/^relayhost =.*/relayhost = [smtp.gmail.com]:587/' /etc/postfix/main.cf || echo 'relayhost = [smtp.gmail.com]:587' | sudo tee -a /etc/postfix/main.cf
grep -q '^smtp_use_tls =' /etc/postfix/main.cf && sudo sed -i 's/^smtp_use_tls =.*/smtp_use_tls = yes/' /etc/postfix/main.cf || echo 'smtp_use_tls = yes' | sudo tee -a /etc/postfix/main.cf
grep -q '^smtp_sasl_auth_enable =' /etc/postfix/main.cf && sudo sed -i 's/^smtp_sasl_auth_enable =.*/smtp_sasl_auth_enable = yes/' /etc/postfix/main.cf || echo 'smtp_sasl_auth_enable = yes' | sudo tee -a /etc/postfix/main.cf
grep -q '^smtp_sasl_security_options =' /etc/postfix/main.cf && sudo sed -i 's/^smtp_sasl_security_options =.*/smtp_sasl_security_options =/' /etc/postfix/main.cf || echo 'smtp_sasl_security_options =' | sudo tee -a /etc/postfix/main.cf
grep -q '^smtp_sasl_password_maps =' /etc/postfix/main.cf && sudo sed -i 's/^smtp_sasl_password_maps =.*/smtp_sasl_password_maps = hash:\/etc\/postfix\/sasl_passwd/' /etc/postfix/main.cf || echo 'smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd' | sudo tee -a /etc/postfix/main.cf
grep -q '^smtp_tls_CAfile =' /etc/postfix/main.cf && sudo sed -i 's/^smtp_tls_CAfile =.*/smtp_tls_CAfile = \/etc\/ssl\/certs\/ca-certificates.crt/' /etc/postfix/main.cf || echo 'smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt' | sudo tee -a /etc/postfix/main.cf

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

#curl --silent -o-  | bash
#curl --silent -o-  | zsh
#removes variables from shell
unset $(grep -v '^#' $OLDPWD/secret | sed -E 's/(.*)=.*/\1/' | xargs)
