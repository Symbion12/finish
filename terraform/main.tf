terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}
provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "master" {
  name        = "k8s-master"
  platform_id = "standard-v1"
  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = "fd859s00ru90mn31cjf4"
      size     = 50
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.main.id
    nat       = true
  }
  metadata = {
    ssh-keys = var.ssh_keys
    user-data = "#cloud-config\nusers:\n  - name: user1\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n"
  }
}

resource "yandex_compute_instance" "app" {
  name        = "k8s-app"
  platform_id = "standard-v1"
  resources {
    cores  = 4
    memory = 8
  }
  
  boot_disk {
    initialize_params {
      image_id = "fd859s00ru90mn31cjf4"
      size     = 50
    }
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.main.id
    nat       = true
  }
  metadata = {
    ssh-keys = var.ssh_keys
    user-data = "#cloud-config\nusers:\n  - name: user1\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n"
  }
}

resource "yandex_compute_instance" "srv" {
  name        = "srv"
  platform_id = "standard-v1"
  resources {
    cores  = 4
    memory = 8
  }
  
  boot_disk {
    initialize_params {
      image_id = "fd859s00ru90mn31cjf4"
      size     = 50
    }
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.main.id
    nat       = true
  }
  metadata = {
    ssh-keys = var.ssh_keys
    user-data = "#cloud-config\nusers:\n  - name: user1\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n"
  }
}

resource "yandex_vpc_network" "main" {
  name = "main-network"
}

resource "yandex_vpc_subnet" "main" {
  name           = "main-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["10.10.0.0/24"]
}
