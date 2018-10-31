# Multiple Peer Launcher with Terraform

Hyperledger fabric initally launches one network on one host with docker-compose, which is easy to use, but too simple, and it can't help deploy the real decentralized network since all containers running on the one single host

To better realize decentralized blockchain network, we intend to simplize the process to launch peer or order or CA on different cloud service providers with terraform.

With the help of terraform, it saves a lot of time to launch multiple instances on different cloud server with one command. Installing docker and pulling down required imaged and running as container can be easy handled with `start_up_script`

Check the folder `gcloud_complete_network`, it's running with one ca, one orderer, two peers belonging to the same organization, and two couchdb backing up peers


