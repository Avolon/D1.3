provider "yandex" {
  token     = var.yandex_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

resource "yandex_vpc_network" "default" {
  name = "sock-shop-network"
}

resource "yandex_vpc_subnet" "default" {
  name           = "sock-shop-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}

resource "yandex_compute_instance" "manager" {
  name = "manager"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8je1tv95hu6l4o63ks" # Ubuntu 20.04 LTS
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
    user-data = <<-EOF
      #cloud-config
      runcmd:
        - [ bash, /etc/install_docker.sh ]
        - [ bash, -c, "docker swarm init --advertise-addr $(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)" ]
    EOF
  }

  provisioner "file" {
    source      = "install_docker.sh"
    destination = "/etc/install_docker.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /etc/install_docker.sh",
      "/etc/install_docker.sh"
    ]
  }

  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    private_key = file(var.private_key_path)
  }
}

resource "yandex_compute_instance" "worker1" {
  name = "worker1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8je1tv95hu6l4o63ks" # Ubuntu 20.04 LTS
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
    user-data = <<-EOF
      #cloud-config
      runcmd:
        - [ bash, /etc/install_docker.sh ]
    EOF
  }

  provisioner "file" {
    source      = "install_docker.sh"
    destination = "/etc/install_docker.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /etc/install_docker.sh",
      "/etc/install_docker.sh"
    ]
  }

  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    private_key = file(var.private_key_path)
  }
}

resource "yandex_compute_instance" "worker2" {
  name = "worker2"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8je1tv95hu6l4o63ks" # Ubuntu 20.04 LTS
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
    user-data = <<-EOF
      #cloud-config
      runcmd:
        - [ bash, /etc/install_docker.sh ]
    EOF
  }

  provisioner "file" {
    source      = "install_docker.sh"
    destination = "/etc/install_docker.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /etc/install_docker.sh",
      "/etc/install_docker.sh"
    ]
  }

  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    private_key = file(var.private_key_path)
  }
}
