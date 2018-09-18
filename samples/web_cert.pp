# example code for a server to generate key and csr
# using code from camptocamp/openssl module
class web_cert(
  String               $priv_key_text,
  String               $common_name,
  Array[String]        $alt_names,
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

  # So we already have a private key, we need to generate a CSR
  # that is exported for our CA to sign and "return" to us.
  @@x509_request { "export_${common_name}.csr":
    ensure      => 'present',
    private_key => $key_file,  # realised this is not going to export the CONTENT, just the pointer :-(
    encrypted   => false,
    
  }
}
