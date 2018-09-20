#!/bin/bash

echo '{'
echo '  "x509_csrs": {'
for fn in `find /etc/pki/tls/csr -name '*.csr' -type f` ; do
  key=`basename $fn | sed 's/\.csr$//'`
  value=`cat $fn | base64 -w 0`
  echo '    "'$key'": {'
  echo '      "csr": "'$value'",'
  echo '    },'
done
echo '  }'
echo '}'
