provider "google" {
  project = var.project
  region  = var.region
}

resource "google_compute_firewall" "firewall" {
  name    = "gritfy-firewall-externalssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"] # Not So Secure. Limit the Source Range
  target_tags   = ["externalssh"]
}

resource "google_compute_firewall" "webserverrule" {
  name    = "gritfy-webserver"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80"] # Allow access to only tcp/80
  }
  source_ranges = ["0.0.0.0/0"] # Not So Secure. Limit the Source Range
  target_tags   = ["webserver"]
}

# We create a public IP address for our google compute instance to utilize
resource "google_compute_address" "static" {
  name = "vm-public-address"
  project = var.project
  region = var.region
  depends_on = [ google_compute_firewall.firewall ]
}

resource "google_compute_instance" "dev" {
  name         = "devserver"
  machine_type = "f1-micro"
  zone         = "${var.region}-a"
  tags         = ["externalssh","webserver"]
  boot_disk {
    initialize_params {
      #image = "centos-cloud/centos-7"
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  
  provisioner "remote-exec" {
    connection {
      host        = google_compute_address.static.address
      type        = "ssh"
      user        = var.user
      timeout     = "500s"
      private_key = file(var.privatekeypath)
    }
    inline = [
        "sudo apt update",
        "sudo apt upgrade -y",
        "sudo apt install apache2 -y",
        "cd /var/www/html",
        "sudo cp index.html index.html.ORIG",
        "echo '<h1>Hello world from Warsaw!</h1>' | sudo tee index.html",
        "sudo apt install software-properties-common",
        "sudo add-apt-repository --yes --update ppa:ansible/ansible",
        "sudo apt install ansible -y",
    ]
  }
  
  # Ensure firewall rule is provisioned before server, so that SSH doesn't fail.
  depends_on = [ google_compute_firewall.firewall, google_compute_firewall.webserverrule ]
  service_account {
    email  = var.email
    scopes = ["compute-ro"]
  }
  
  metadata = {
    ssh-keys = "${var.user}:${file(var.publickeypath)}"
  }
}

resource "google_compute_instance" "node1" {
  name         = "node1"
  machine_type = "f1-micro"
  zone         = "${var.region}-a"
  tags         = ["managed"]
  
  boot_disk {
    initialize_params {
      #image = "centos-cloud/centos-7"
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  
  network_interface {
    network = "default"
  }
  
  # Ensure firewall rule is provisioned before server, so that SSH doesn't fail.
  depends_on = [ google_compute_firewall.firewall, google_compute_firewall.webserverrule ]
  service_account {
    email  = var.email
    scopes = ["compute-ro"]
  }
  
  metadata = {
    ssh-keys = "${var.user}:${file(var.publickeypath)}"
  }
  
}



resource "google_compute_instance" "node2" {
  name         = "node2"
  machine_type = "f1-micro"
  zone         = "${var.region}-a"
  tags         = ["managed"]
  
  boot_disk {
    initialize_params {
      #image = "centos-cloud/centos-7"
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  
  network_interface {
    network = "default"
  }
  
  # Ensure firewall rule is provisioned before server, so that SSH doesn't fail.
  depends_on = [ google_compute_firewall.firewall, google_compute_firewall.webserverrule ]
  service_account {
    email  = var.email
    scopes = ["compute-ro"]
  }
  
  metadata = {
    ssh-keys = "${var.user}:${file(var.publickeypath)}"
  }
  
}

resource "google_compute_instance" "node3" {
  name         = "node3"
  machine_type = "f1-micro"
  zone         = "${var.region}-a"
  tags         = ["managed"]
  
  boot_disk {
    initialize_params {
      #image = "centos-cloud/centos-7"
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  
  network_interface {
    network = "default"
  }
  
  # Ensure firewall rule is provisioned before server, so that SSH doesn't fail.
  depends_on = [ google_compute_firewall.firewall, google_compute_firewall.webserverrule ]
  service_account {
    email  = var.email
    scopes = ["compute-ro"]
  }
  
  metadata = {
    ssh-keys = "${var.user}:${file(var.publickeypath)}"
  }
  
}


