#!bin/sh
cd home
echo "hi" > halo.txt

#Set up the repository 
sudo apt-get update
sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common <<-EOF
Y
EOF
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
# install docker ce
sudo apt-get update
sudo apt-get install docker-ce <<-EOF
Y
EOF
#Add user into admin so that sudo is not necessary anymore to run docker
sudo usermod -aG docker $USER
#Can avoid using sudo temporarily, but once after ssh, it still needs to execute it again and re-enter the terminal page
#for the rest, pulling image from the docker-hub and run it detached 
docker run -d hyperledger/fabric-peer 
# when reach here, it should be supposed that docker has already been installed
# run hello-world check 






 