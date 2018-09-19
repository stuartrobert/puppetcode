# this class goes on the server running the CA
class ca_server(
) {

  # Our resources should be declared like this:
  @@csr_file { 'www.example.com':
    content => $key_pem_string,
    
  }
  # we want all our new CSR resources with our special tag
  # to go to the right place. So we set some defaults here:
  File {
    mode    => '0644',
    content => this is the bit we are collecting,
  }
  # instantiate all CSRs in the appropriate place
  File <<| tag == 'csrs' |>>

}
