#############################GCP BLOW###############################
resource "google_compute_instance" "default" {
  name         = "one"
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

output "ip" {
  value = "${azurerm_resource_group.network.id}"
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
