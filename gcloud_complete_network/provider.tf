provider "google" {
  credentials = "${file("./../credential/fintelics-219722-d77566503f9c.json")}"
  project     = "fintelics-219722"
  region      = "us-east1"
  zone        = "us-east1-b"
}
