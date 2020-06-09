# zandronum

 Deploy a Zandronum server in Linode.

# Requirements

* a Linode account.
* the `linode.ssh_key` resource is handled elsewhere.
* a directory containing all desired files to upload.

# Usage

To use this module, in your `main.tf` TerraForm code for a deployment insert the following:

``` code
module "zandronum" {
  source = "github.com/frozenfoxx/terraform-zandronum-linode"

  authorized_keys = ["${linode_sshkey.terraform.ssh_key}"]
  config          = var.zandronum_server_config
  image           = var.image
  name            = "zandronum"
  options         = var.zandronum_options
  private_key     = chomp(file(var.private_ssh_key))
  region          = var.region
  type            = var.type
  wads_upload_dir = var.wads_upload_dir
}
```
