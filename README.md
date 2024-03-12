![Terraform Module Test](https://github.com/rmnobarra/azure-virtual-machine-terraform-module/actions/workflows/workflow.yaml/badge.svg)

# Terraform Azure Virtual Machine Module

This Terraform module creates an Azure Virtual Machine with a managed disk and ssh key pair.

## Usage

```hcl
module "resource_group" {
  source    = "git::https://github.com/rmnobarra/azure-virtual-machine-terraform-module.git?ref=v1.0.0"
  rg_name   = "meu-grupo-de-recursos"
  location = "westus3"
}
```


Theres a fullexample in `/examples` folder.