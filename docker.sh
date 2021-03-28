sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common  -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - 
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" 
sudo apt update
sudo apt install docker-ce -y
sudo curl -L https://github.com/docker/compose/releases/download/$dockercompose/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose 
sudo chmod +x /usr/local/bin/docker-compose
