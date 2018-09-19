# example code for a server to generate key and csr
# using code from camptocamp/openssl module
class web_client_example(
  String               $priv_key_text, # we want our private key coming in via yaml in order to use eyaml
  String               $common_name,
  Array[String]        $altnames,
  Array[String]        $extkeyusage, # see https://github.com/camptocamp/puppet-openssl/blob/master/manifests/certificate/x509.pp
                                     # for valid values
  Stdlib::Absolutepath $csr_dir = '/etc/pki/tls/csr',
  Stdlib::Absolutepath $crt_dir = '/etc/pki/tls/crt',
  Stdlib::Absolutepath $key_dir = '/etc/pki/tls/private',
) {

  # define where we are putting our private keys
  $key_file = "${key_dir}/${common_name}.key"

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
