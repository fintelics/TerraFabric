#!bin/sh
cd home
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
docker run -d hyperledger/fabric-ca --name ca.example.com --network="fabcar-cloud" -p 7054:7054 \

-e FABRIC_CA_HOME=/etc/hyperledger/fabric-ca-server \
-e FABRIC_CA_SERVER_CA_NAME=ca.example.com \
-e FABRIC_CA_SERVER_CA_CERTFILI=/etc/hyperledger/fabric-ca-server-condig/ca.org1.example.com-cert.pem \
-e FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/4239aa0dcd76daeeb8ba0cda701851d14504d31aad1b2ddddbac6a57365e497c_sk \

# when reach here, it should be supposed that docker has already been installed
# run hello-world check 
# Once the container has already been created, go inside that container and execute command
 docker exec -d ca.example.com sh -c 'fabric-ca-server start -b admin:adminpw'





 