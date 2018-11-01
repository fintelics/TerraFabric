# Multiple Peer Launcher with Terraform

Hyperledger fabric initally launches one network on one host with docker-compose, which is easy to use, but too simple, and it can't help deploy the real decentralized network since all containers running on the one single host

To better realize decentralized blockchain network, we intend to simplize the process to launch peer or order or CA on different cloud service providers with terraform.

## How to do that
With the help of terraform, it saves a lot of time to launch multiple instances on different cloud server with one command. Installing docker and pulling down required imaged and running as container can be easy handled with `start_up_script`

Check the folder `gcloud_complete_network`, it's running with one ca, one orderer, two peers belonging to the same organization, and two couchdb backing up peers. Make sure the network interface is configured in a good way, so that instance can talk with each other.

We first take the peer0 as example

```
resource "google_compute_instance" "peer0"{

}
```
First create the corrected resource based on cloud provider and dservice that should be picked. 

```
resource "google_compute_instance" "peer0"{
name = "peer0"
machine_type="n1_standard-1"
zone = "us-central1-a"

}
```
The name here refers to the instance name, and the "peer0" after "google_compute_instance" refers to the resource. Don't mess it up.

Google provides many [machine types](https://cloud.google.com/compute/docs/machine-types), so does aws and other cloud providers. We will talk about them later.

We choose n1_standard-1 here, since it's the base choice, in other words, it costs least. For the zone, I would suggest choose it based on the geographical location for better performance. 

```
resource "google_compute_instance" "peer1" {
  name         = "peer1"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  scratch_disk {}

  network_interface {
    network = "default"

    access_config {
    }
  }

```
The related documentation is attached [here](https://www.terraform.io/docs/providers/google/r/compute_instance.html)

Here we choose "debian-cloud/debian-9" as initialize image,
and leave it blank in scratch_disk, because we don't attach any disk with the instance.

network_interface is a required field to define the network configuration including `network` ,`subnetwork` and `address_ip`
we choose default here because for right now, the inside structure is more important, and we set the access_config as blank.
```
resource "google_compute_instance" "peer1" {
  name         = "peer1"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  scratch_disk {}

  network_interface {
    network = "default"

    access_config {
    }
  }
  metadata {
    startup-script = <<SCRIPT
      ${file("startup.sh")}
    SCRIPT
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
}
```

we insert the file `startup.sh` into the container and let it excute when instances launch. For different containers, we use different scripts to launch. 

For service account, it relates with [service account](https://cloud.google.com/iam/docs/granting-roles-to-service-accounts?_ga=2.42888045.-958217068.1539465486). 


To launch all instance, provider information is also required.
And for different clouds, there are different setting.

For instance, gcp requires as follow
```
provider "google" {
  credentials = "${file("account.json")}"
  project     = "my-project-id"
  region      = "us-central1"
}
```

account.js file can be found service account

Once all fields are fulfilled, under the correct dirctory

`terraform init` first do download gcp version, 
then go `terraform apply` to apply resource 









