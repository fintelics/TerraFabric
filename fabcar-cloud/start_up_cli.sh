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
docker run -d --tty --name cli \
-e GOPATH=/opt/gopath \
-e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock \
-e CORE_LOGGING_LEVEL=info \
-e CORE_PEER_ID=cli \
-e CORE_PEER_ADDRESS=peer0.org1.example.com:7051 \
-e CORE_PEER_LOCALMSPID=Org1MSP \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp \
-e CORE_CHAINCODE_KEEPALIVE=10 \
-w /opt/gopath/src/github.com/hyperledger/fabric/peer \
hyperledger/fabric-tools
# when reach here, it should be supposed that docker has already been installed
# run hello-world check 






 