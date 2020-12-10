#!/usr/bin/env bash
## Instructions in three steps:
# 1. Uncomment next line if you would like to see detailed openstack logs for debug
# export OS_DEBUG=1
# 2. Copy the next 9 lines to a file in your home directory. Name the file
## ~/.terraform_env
#    Uncomment the lines that begin with 'export'
#    Edit the next line to update your I NUMBER
# export OS_USERNAME=<YOUR D/I NUMBER>
#    Edit the next line to update path to ssh private key
# export TF_VAR_key_file_path=<path/to/private_key>
#    Edit the next line to the display name of ssh key pair used for ccloud intial login
# export TF_VAR_key_pair=<KEY_NAME>
##  End Copy
## If you've set up that environment correctly, the next line should import those details
if [  -f ~/.terraform_env ] ; then
    source  ~/.terraform_env
else
    echo "Cannot find OS_USERNAME and other details."
    echo "Check that ~/.terraform_env is correct."
    # Note: if we use "exit 1" here, the entire shell closes
    #     without indicating what went wrong.
    # Use "return 1" instead.
    return 1
fi
# 3. Set the number of instances you are creating, below, with TF_VAR_instances_count
export OS_IDENTITY_API_VERSION=3
export OS_REGION_NAME="<my-region>"
export OS_PROJECT_DOMAIN_ID="<domain_id>"
export OS_AUTH_URL=https://<url>:443/v3
export OS_PROJECT_ID="<project_id>"
export OS_PROJECT_DOMAIN_ID="<domain_id>"
export OS_USER_DOMAIN_ID="<user_domain_id>"

# openstack login info
if [ -z $OS_PASSWORD ]; then
    read -s -p "Enter Your Password:" OS_PASSWD
    export OS_PASSWORD=$OS_PASSWD
fi
# terraform environment variables
export TF_LOG=WARN  # Other valid options are TRACE DEBUG INFO WARN ERROR
export TF_LOG_PATH=./terra.log
# image_name is easier to work with than image_id, but image names
# will be updated. As long all packages remain the same this is not
# an issue but we need to be aware that if a specific image is needed, we
# need to determine the image ID and use that instead.
export TF_VAR_image_name='debian-10-openstack-amd64'
#export TF_VAR_image_id='<image_id>'
# The next line assumes that a flavor exists
# Ref: https://docs.openstack.org/nova/pike/admin/flavors.html
# For a list of flavors: openstack flavor list
export TF_VAR_flavor='<flavor_id>'
export TF_VAR_volume_size='100' 
export TF_VAR_network_name='<network_name>'
export TF_VAR_network_uuid='<network_uuid>'
export TF_VAR_dns_zone_name='<dns_zone>'
export TF_VAR_dns_zone_uuid='<dns_zone_uuid>'
export TF_VAR_instances_count=2
export TF_VAR_name_prefix='["jumphost01", "webserver01"]'
export TF_VAR_ssh_user_name='<myusername>'
export TF_VAR_floating_ip_pool='<floating_ip_pool>'
export TF_VAR_availability_zone='zone_id' # may or may not = OS_PROJECT_DOMAIN_ID
export TF_VAR_security_groups='["default", "Tight", "NFS"]'
