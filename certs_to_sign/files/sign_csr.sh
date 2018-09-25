#!/bin/bash
# managed by PUPPET
#
# This script expects an already existing CA is set up with a key in /etc/pki/CA
# you should probably take care not to mangle that directory by using other CA scripts
# Start your CA with something like the following:
#   Create a openssl.config file with appropriate values for 
#
# cd /etc/pki/CA; openssl ca -config /etc/pki/CA/openssl.cnf -policy policy_anything -extensions v3_ca -out certs/subca.crt -in /tmp/subca.csr
# $1 = CSR
# mangle CSR file name to get the name minus the extension

openssl ca -in $1 -out /tmp/some_file_name.$$
