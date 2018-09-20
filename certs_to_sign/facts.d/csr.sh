#!/bin/bash

for fn in `find /etc/pki/tls/csr -name '*.csr' -type f` ; do
  key=`basename $fn`
  value=`cat $fn | base64 -w 0`
  echo "$key"=\'"$value"\'
done
