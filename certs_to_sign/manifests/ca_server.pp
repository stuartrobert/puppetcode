# this class goes on the server running the CA
class cert_to_sign::ca_server(
) {

  # instantiate all CSRs in the appropriate place
  Certs_to_sign::X509_csr <<| |>>

  file { '/root/sign_csr.sh':
    ensure => 'file',
    source => 'puppet:///modules/cert_to_sign/sign_csr.sh',
    mode   => '0700',
    owner  => 'root',
    group  => 'root',
  }

  exec { '/root/sign_csr.sh':
    command     => '/var/www/html/certs',
    refreshonly => true,
  }
}
