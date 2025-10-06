resource "google_compute_network" "web_app_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "web_app_subnet" {
  name          = var.subnet_name
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.web_app_vpc.id
}

# Regla de firewall HTTPS (443)
resource "google_compute_firewall" "allow_https" {
  name    = "allow-https"
  network = google_compute_network.web_app_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
  description   = "Allow HTTPS traffic from anywhere"
}

# Regla de firewall SSH (22)
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-webapp"
  network = google_compute_network.web_app_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-server"]
  description   = "Allow SSH access to instances with tag ssh-server"
}

# Salidas
output "network_name" {
  value = google_compute_network.web_app_vpc.name
}

output "subnet_self_link" {
  value = google_compute_subnetwork.web_app_subnet.self_link
}
