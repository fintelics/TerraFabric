#############################GCP 1 BLOW###############################
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

  // Local SSD disk
  scratch_disk {}

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
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
}

#############################GCP 1 BLOW###############################
resource "google_compute_instance" "peer2" {
  name         = "peer2"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {}

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
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
}

#############################AWS BLOW###############################
resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  key_name      = "ine"

  vpc_security_group_ids = [
    "sg-036cb77176ce92f80",
  ]

  connection {
    type        = "ssh"
    private_key = "${file("ine.pem")}"
    user        = "ec2-user"
    timeout     = "2m"
  }

  provisioner "file" {
    source      = "/startup.sh"
    destination = "/home/ubuntu"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x startup.sh",
      "./startup.sh",
    ]
  }
}

resource "aws_s3_bucket" "b" {
  bucket = "fintelics666"
  acl    = "private"
}

resource "aws_s3_bucket_object" "a" {
  bucket = "fintelics666"
  key    = "test"
  source = "test.txt"
  etag   = "${md5(file("test.txt"))}"
}

#############################Azure BLOW###############################

resource "azurerm_resource_group" "network" {
  name     = "production"
  location = "West US"
}

resource "azurerm_virtual_network" "network" {
  name                = "production-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.network.location}"
  resource_group_name = "${azurerm_resource_group.network.name}"

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.0.3.0/24"
  }
}

output "ip" {
  value = "${azurerm_virtual_network.network.id}"
}
