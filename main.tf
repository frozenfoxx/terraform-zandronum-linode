resource "linode_instance" "main" {
  label           = var.name
  image           = var.image
  region          = var.region
  type            = var.type
  authorized_keys = var.authorized_keys
  root_pass       = var.root_pass

  group = var.group
  tags = var.tags

  connection {
    type        = "ssh"
    user        = "root"
    agent       = "false"
    password    = var.root_pass
    private_key = var.private_key
    host        = self.ip_address
  }

  provisioner "file" {
    source      = "${path.module}/scripts"
    destination = "/tmp"
  }

  provisioner "file" {
    source      = var.wads_upload_dir
    destination = "/tmp/wads"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 755 /tmp/scripts/*.sh",
      "mv /tmp/scripts/* /usr/local/bin/",
      "/usr/local/bin/install_fail2ban.sh",
      "/usr/local/bin/install_docker.sh",
      "mv /tmp/wads /data/wads",
      "CONFIG=\"${var.config}\" OPTIONS=\"${var.options}\" /usr/local/bin/install_zandronum_server.sh"
    ]
  }
}
