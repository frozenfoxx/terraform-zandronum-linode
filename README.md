# zandronum

Deploy a [Zandronum](https://zandronum.com/) server in [Linode](https://linode.com).

# Requirements

* a Linode account.
* a directory containing all desired files to upload.

# Usage

To use this module, in your `main.tf` TerraForm code for a deployment insert the following:

``` code
module "zandronum" {
  source = "github.com/frozenfoxx/terraform-zandronum-linode"

  authorized_keys = [chomp(file(var.public_ssh_key))]
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

# Server Control

Scripts and files on disk are provided for ease of control of the Zandronum server.

* **Control script**: `/usr/local/bin/zandronum_server.sh`.
* **Configuration files**
  * `/data/zandronum_server_config`: `base64`-encoded server configuration INI file.
  * `/data/zandronum_server_options`: plaintext string of options to provide to the server.
* **Data files**: `/data/wads`.
* **Procedures**
  * **Fresh installation**: `CONFIG=[base64 server INI] OPTIONS=[string of options] /usr/local/bin/zandronum_server.sh install`
  * **Adjust options**: `[edit either or both files] ; /usr/local/bin/zandronum_server.sh restart`
