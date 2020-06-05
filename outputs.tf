output "vm_name" {
  value = linode_instance.main.label
}

output "vm_ip" {
  value = "${data.linode_networking_ip.v4.address}/${data.linode_networking_ip.v4.prefix} (${data.linode_networking_ip.v4.rdns})"
}

output "vm_ip6" {
  value = "${data.linode_networking_ip.v6.address}/${data.linode_networking_ip.v6.prefix} (${data.linode_networking_ip.v6.rdns})"
}
