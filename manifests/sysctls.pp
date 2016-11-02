class elbase::sysctls {

  exec {
    'sysctl-restart':
      command     => 'sysctl -p',
      path        => '/sbin:/usr/sbin:/bin:/usr/bin',
      refreshonly => true;
  }

  file {
    '/etc/sysctl.d/disable_ipv6.conf':
      ensure  => file,
      source  => 'puppet:///modules/elbase/disable_ipv6_sysctl.conf',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      notify => Exec['sysctl-restart'];
    '/etc/sysctl.d/enable_ipv4_forward.conf':
      ensure  => file,
      source  => 'puppet:///modules/elbase/enable_ipv4forward_sysctl.conf',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      notify => Exec['sysctl-restart'];
    '/etc/sysctl.d/ipv4_secure.conf':
      ensure  => file,
      source  => 'puppet:///modules/elbase/ipv4_secure_sysctl.conf',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      notify => Exec['sysctl-restart'];
  }
}
