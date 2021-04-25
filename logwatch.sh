echo "configuring Log watch"
sudo cp --archive /etc/cron.daily/00logwatch /etc/cron.daily/00logwatch-COPY-$(date +"%Y%m%d%H%M%S")
sudo cp --archive /etc/cron.daily/00logwatch /server/bin/defaults/00logwatch-COPY-$(date +"%Y%m%d%H%M%S")
sudo chmod -x /etc/cron.daily/00logwatch-COPY*
sudo grep -q '^MailTo = root' /usr/share/logwatch/default.conf/logwatch.conf && sudo sed -i 's/^MailTo = root.*/MailTo = $gmailuser/' /usr/share/logwatch/default.conf/logwatch.conf || echo 'MailTo = $gmailuser' | sudo tee -a /usr/share/logwatch/default.conf/logwatch.conf
sudo sed -i -r -e "s,^($(sudo which logwatch).*?),# \1         # commented by $(whoami) on $(date +"%Y-%m-%d @ %H:%M:%S")\n$(sudo which logwatch) --output mail --format html --mailto root --range yesterday --service all         # added by $(whoami) on $(date +"%Y-%m-%d @ %H:%M:%S")," /etc/cron.daily/00logwatch
