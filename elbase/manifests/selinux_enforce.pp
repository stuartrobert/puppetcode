class elbase::selinux_enforce () {

  exec { "Selinux in enforcing mode":
    command => "setenforce Enforcing",
    unless  => "getenforce |grep Enforcing";
  }
}
