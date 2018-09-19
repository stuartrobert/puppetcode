# example code for a server to generate key and csr
# using code from camptocamp/openssl module
class web_cert(
  String               $priv_key_text,
  String               $common_name,
  Array[String]        $altnames,
  Array[String]        $extkeyusage,
  Stdlib::Absolutepath $csr_dir = $ca_params::csr_dir,
  Stdlib::Absolutepath $crt_dir = $ca_params::crt_dir,
) inherits ca_params {

  # define where we are putting our private keys
  $key_dir = '/etc/pki/tls/private'
  $key_file = "${key_dir}/${common_name},key"

  file { $key_file:
    ensure  => 'file',
    content => Sensitive($priv_key_text),
    mode    => '0750',
    owner   => 'root',
    group   => 'root',
  }

  if !empty($altnames+$extkeyusage) {
    $req_ext = true
  } else {
    $req_ext = false
  }
  
  export_csr { 'common.example.com':
    key => 'text of CSR goes here',
  }

  # So we already have a private key, we need to generate a CSR
  # that is exported for our CA to sign and "return" to us.
  x509_request { "${common_name}.csr":
    ensure      => 'present',
    private_key => $key_file,
    encrypted   => false,
    
  }
}
