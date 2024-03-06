terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.82.0"
    }
  }
}

provider "google" {
  # Configuration options
  credentials = file("cred.json")
  project = "afa-practicagcp-keepcoding"
  region = "europe-west3"
  zone =  "europe-west3-a"
}

resource "google_compute_network" "red-practica-terraform" {
  name = var.mi_red
}

resource "google_compute_address" "terraform-ip" {
    name = var.mi_ip
}

resource "random_string" "random" {
  length = var.rand_lenght
  special = var.rand_special
  upper = var.rand_upper
}

resource "google_storage_bucket" "bucket-practica-terraform" {
    name = "bucket-project-terraform-${random_string.random.result}"
    location = var.locate
}

resource "google_compute_instance" "terraform-instance" {
    depends_on = [google_compute_network.red-practica-terraform, google_compute_address.terraform-ip]
  name         = var.inst_name
  machine_type = var.inst_type
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = var.inst_image
    }
  }

  network_interface {
    network = google_compute_network.red-practica-terraform.name
    access_config {
      nat_ip = var.inst_nat
    }
  }

}
