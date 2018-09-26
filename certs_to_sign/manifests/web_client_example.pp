# type to drop a key and make a csr
# using code from camptocamp/openssl module
define certs_to_sign::make_csr(
  String               $priv_key_text, # we want our private key coming in via yaml in order to use eyaml
  String               $common_name,
  Array[String]        $altnames = [],
  # extkeyusage:  https://github.com/camptocamp/puppet-openssl/blob/master/manifests/certificate/x509.pp
  # or man x509v3_config from openssl package for valid values
  Array[String]        $extkeyusage = [
    'serverAuth',
    'clientAuth',
  ],
  String               $email = 'some_email@example.com',
  String               $orgunit = 'IT Services',
  String               $organisation = 'Best Place',
  String               $locality = 'Brisbane',
  String               $state = 'Queensland',
  String               $country = 'AU',
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

  # configure var for openssl.conf file
  if !empty($altnames+$extkeyusage) {
    $req_ext = true
  } else {
    $req_ext = false
  }

  # write out our openssl.conf for this CSR
  file { "${csr_dir}/${common_name}-openssl.conf":
    ensure  => 'file',
    content => template("${module_name}/openssl.conf.erb"),
  }

  # So we already have a private key, we need to generate a CSR
  # that is exported for our CA to sign and "return" to us.
  x509_request { "${csr_dir}/${common_name}.csr":
    ensure      => 'present',
    private_key => $key_file,
    template    => "${module_name}/openssl.conf.erb",
    encrypted   => false,
    force       => false,
  }

  # grab the CSRs that have been converted to facts by the next run
  # so that we can export the resources
  if defined($facts['x509_csrs']) {
    create_resources($module_name::x509_csr, $facts['x509_csrs'])
  }
}

