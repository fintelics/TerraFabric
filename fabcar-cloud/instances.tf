############################# peer0 ############################

resource "google_compute_instance" "peer0" {
  name         = "peer0"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  scratch_disk {}

  network_interface {
    network = "fabric-network"

    access_config {}
  }

  metadata {
    startup-script = <<SCRIPT
        ${file("start_up_peer.sh")}
    SCRIPT
  }
}

############################# orderer0 ############################

resource "google_compute_instance" "orderer0" {
  name         = "orderer0"
  machine_type = "n1-standard-1"
  zone         = "asia-east1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  provisioner "file" {
    source      = "./config"
    destination = "HOME/orderer"
  }

  provisioner "file" {
    source      = "./crypto-config"
    destination = "HOME/orderer"
  }

  scratch_disk {}

  network_interface {
    network = "fabric-network"

    access_config {}
  }

  metadata {
    startup-script = <<SCRIPT
        ${file("start_up_orderer.sh")}
    SCRIPT
  }
}

############################# fabric-ca ############################

resource "google_compute_instance" "ca" {
  name         = "ca"
  machine_type = "n1-standard-1"
  zone         = "asia-east2-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  scratch_disk {}

  network_interface {
    network = "fabric-network"

    access_config {}
  }

  metadata {
    startup-script = <<SCRIPT
        ${file("start_up_ca.sh")}
    SCRIPT
  }
}

############################# couchDB0 ############################

resource "google_compute_instance" "couchDB0" {
  name         = "couch0"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  scratch_disk {}

  network_interface {
    network = "fabric-network"

    access_config {}
  }

  metadata {
    startup-script = <<SCRIPT
        ${file("start_up_couchDB.sh")}
    SCRIPT
  }
}

############################# cli ############################

resource "google_compute_instance" "cli" {
  name         = "cli"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  scratch_disk {}

  network_interface {
    network = "fabric-network"

    access_config {}
  }

  metadata {
    startup-script = <<SCRIPT
        ${file("start_up_cli.sh")}
    SCRIPT
  }
}

############################provider ##############################
provider "google" {
  credentials = "${file("./../credential/fintelics-219722-d77566503f9c.json")}"
  project     = "fintelics-219722"
  region      = "us-east1"
  zone        = "us-east1-b"
}
