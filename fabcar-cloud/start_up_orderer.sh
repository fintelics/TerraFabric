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
docker run -d hyperledger/fabric-orderer \
-e ORDERER_GENERAL_LOGLEVEL=info
-e ORDERER_GENERAL_LISTENADDRESS=      \
-e ORDERER_GENERAL_GENESISMETHOD=file  \
-e ORDERER_GENERAL_GENSISFILE=/etc/hyperledger/configtx/gensis.block \
-e ORDERER_GENERAL_LOCALMSPID=OrdererMSP   \
-e ORDERER_GENERAL_LOCALMSPDIR=/etc/hyperledger/msp/orderer/msp  \
-w /opt/gopath/src/github.com/hyperledger/fabric/orderer \
-v orderer/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp/:/etc/hyperledger/msp/peer \
-v orderer/crypto-config/peerOrganizations/org1.example.com/users:/etc/hyperledger/msp/users   \
-v orderer/config:/etc/hyperledger/configtx  #might be problem




# when reach here, it should be supposed that docker has already been installed
# run hello-world check







 