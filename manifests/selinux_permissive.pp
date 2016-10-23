class elbase::selinux_permissive () {

  exec { "Selinux in permissive mode":
    command => "setenforce Permissive",
    unless  => "getenforce |grep Permissive";
  }
}
