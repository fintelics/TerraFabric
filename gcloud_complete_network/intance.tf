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

############################# peer1 ############################

resource "google_compute_instance" "peer1" {
  name         = "peer1"
  machine_type = "n1-standard-1"
  zone         = "asia-east1-a"

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

############################# couchDB1 ############################

resource "google_compute_instance" "couchDB1" {
  name         = "couch1"
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
