terraform {
  required_providers {
    openstack = "~> 1.28"
  }
}
resource "openstack_networking_floatingip_v2" "floating_ip" {
  count = var.instances_count
  pool  = var.floating_ip_pool
}

resource "openstack_compute_instance_v2" "myproj" {
  count             = var.instances_count
  name              = element(var.name_prefix, count.index)
  image_id          = var.image_id
  flavor_id         = var.flavor
  key_pair          = var.key_pair
  availability_zone = var.availability_zone
  security_groups   = var.security_groups

  network {
    name           = var.network_name
    uuid           = var.network_uuid
    access_network = true
  }

  connection {
    type        = ssh
    user        = var.ssh_user_name
    private_key = file(var.key_file_path)
    timeout     = "5m"
  }
}

resource "openstack_blockstorage_volume_v2" "myproj_volume" {
  count             = var.instances_count
  name              = "${element(var.name_prefix, count.index)}-Volume"
  size              = var.volume_size
  availability_zone = var.availability_zone
}

resource "openstack_compute_volume_attach_v2" "attach_myproj_volumes" {
  count       = var.instances_count
  instance_id = element(openstack_compute_instance_v2.myproj.*.id, count.index)
  volume_id   = element(openstack_blockstorage_volume_v2.myproj_volume.*.id, count.index)
}

resource "openstack_compute_floatingip_associate_v2" "attach_ip_to_instance" {
  count       = var.instances_count
  floating_ip = element(openstack_networking_floatingip_v2.floating_ip.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.myproj.*.id, count.index)

  connection {
    host        = self.floating_ip
    user        = var.ssh_user_name
    private_key = file(var.key_file_path)
    agent       = false
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    scripts = [
      "./bin/install_tools.sh",
      ]
  }

  provisioner "remote-exec" {
    inline = [
      "cd ~; mkdir -p /home/suser/dont-touch",
    ]
  }
}

resource "openstack_dns_recordset_v2" "myproj_dns_recordset" {
  count       = var.instances_count
  name        = "${element(var.name_prefix, count.index)}${var.dns_zone_name}"
  zone_id     = var.dns_zone_uuid
  records     = list(element(openstack_networking_floatingip_v2.floating_ip.*.address, count.index))
  ttl         = 1800
  type        = "A"
}

output "instance_ips" {
  value = [openstack_networking_floatingip_v2.floating_ip.*.address]
}

