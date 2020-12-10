# Creating a new instance using terraform

## Pre-requisites:
- Info is known to fill out to fill out the variables in openrc.sh
- An existing OpenStack Project
- Access to an account that can provision items in OpenStack Project

## Instructions
1. Copy the next lines to a file in your home directory. Name the file `~/.terraform_env`
```
# Uncomment next line if you would like to see detailed OpenStack logs for debug
# export OS_DEBUG=1
#    Edit the next line to update your user ID/name
export OS_USERNAME=<username>
#    Edit the next line to update path to ssh private key
export TF_VAR_key_file_path=<path/to/private_key>
#    Edit the next line to the display name of ssh key pair used for  initial login
export TF_VAR_key_pair=<KEY_NAME>
##  End Copy
```
2. Fill out and source openrc.sh
3. `terraform init`
4. `terraform plan` !! Verify Terraform operations are what is expected !!
5. `terraform apply`
