# this class goes on the server running the CA
class profile::ca_server(
) {

  # instantiate all CSRs in the appropriate place
  Certs_to_sign::X509_csr <<| |>>

  exec { 'sign_csr.sh':
    cwd         => '/var/www/html/public',
    command     => '/bin/openssl ca blah blah',
    refreshonly => true,
  }

}
