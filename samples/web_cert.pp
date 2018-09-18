# example code for a server to generate key and csr
# using code from camptocamp/openssl module
class web_cert(
  String $priv_key,
  String $common_name,
  Array[String] $alt_names,
) {

  openssl::pkey 
}
