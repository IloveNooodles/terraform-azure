# Terraform Azure

An attempt to understand terraform in azure.

## Explanation

It will create 4 servers with specific configuration that available in the `main.tf`

Use `terraform init` to install the `azurerm` provider. Make sure to install `azure cli (az)` first and then login to it.

We can see what terraform will make by using `terraform plan` and just apply it using `terraform apply`
