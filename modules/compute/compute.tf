resource "google_compute_instance" "web_server" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["web-server","ssh-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = var.subnet_self_link

    access_config {
      # Esto asigna una IP pública automáticamente
    }
  }

   metadata = {
    # Añadimos la clave SSH automáticamente si existe
    ssh-keys = fileexists("~/.ssh/id_rsa_tf.pub") ? "tux:${file("~/.ssh/id_rsa_tf.pub")}" : null
  }

  # Espera hasta que la VM esté lista antes de continuar
  provisioner "remote-exec" {
    inline = [
      "sudo systemctl enable ssh",
      "sudo systemctl start ssh"
    ]

    connection {
      type        = "ssh"
      user        = "tux"
      private_key = file("~/.ssh/id_rsa_tf")
      host        = self.network_interface[0].access_config[0].nat_ip
    }
  }
}

output "web_server_ip" {
  value = google_compute_instance.web_server.network_interface[0].access_config[0].nat_ip
}

