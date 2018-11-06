provider "google" {
  credentials = "${file("./credential/fintelics-219722-d77566503f9c.json")}"
  project     = "fintelics-219722"
  region      = "us-east1"
  zone        = "us-east1-b"
}

provider "aws" {
  access_key = "AKIAILQKATOSRQDG43SA"
  secret_key = "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"
  region     = "us-east-1"
}

provider "azurerm" {
  subscription_id = "0e9147cd-8100-4e07-9ea8-dac9f3d9b4e0"
  client_id       = "a3d03735-5dfc-4763-90b9-8fb3d0ba5ba0"
  client_secret   = "01647ed0-91a9-4b1d-b8a0-1b8ae3a42b07"
  tenant_id       = "78aac226-2f03-4b4d-9037-b46d56c55210"
}
