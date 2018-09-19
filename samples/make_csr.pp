# wrapper around openssl modules x509_request type
define make_csr(
  String                         $country,
  String                         $organization,
  String                         $commonname,
  Optional[String]               $state = undef,
  Optional[String]               $locality = undef,
  Optional[String]               $unit = undef,
  Array[String]                  $altnames = [],
  Array[String]                  $extkeyusage = [],
  Optional[String]               $email = undef,
  Integer                        $days = 730,
  Stdlib::Absolutepath           $csr_dir = '/etc/pki/tls/csr',
  Stdlib::Absolutepath           $cnf_dir = $csr_dir,
  Integer                        $key_size = 2048,
  String                         $cnf_tpl = 'cert.cnf.erb',
) {

}
