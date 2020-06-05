data "linode_networking_ip" "v4" {
  address = linode_instance.main.ip_address
}

data "linode_networking_ip" "v6" {
  address = replace(linode_instance.main.ipv6, "/64", "")
}
