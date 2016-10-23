class elbase::sysctls {

  exec {
    'sysctl-restart':
      command     => 'sysctl -p',
      path        => '/sbin:/usr/sbin:/bin:/usr/bin',
      refreshonly => true;
  }

  augeas {
    'base-sysctl-conf':
      context => '/files/etc/sysctl.conf',
      changes => [
        'set kernel.randomize_va_space 2',
        'set net.ipv4.ip_forward 0',
        'set net.ipv6.conf.all.disable_ipv6 1',
        'set net.ipv6.conf.default.disable_ipv6 1',
        'set net.ipv4.conf.all.send_redirects 0',
        'set net.ipv4.conf.all.accept_redirects 0',
        'set net.ipv4.conf.all.secure_redirects 0',
        'set net.ipv4.conf.all.accept_source_route 0',
        'set net.ipv4.conf.all.log_martians 0',
        'set net.ipv4.conf.all.rp_filter 1',
        'set net.ipv4.conf.default.send_redirects 0',
        'set net.ipv4.conf.default.accept_redirects 0',
        'set net.ipv4.conf.default.secure_redirects 0',
        'set net.ipv4.conf.default.accept_source_route 0',
        'set net.ipv4.conf.default.log_martians 0',
        'set net.ipv4.conf.default.rp_filter 1',
        'set net.ipv4.icmp_echo_ignore_broadcasts 1',
        'set net.ipv4.icmp_ignore_bogus_error_responses 1',
        'set net.ipv4.tcp_syncookies 1',
      ],
      notify => Exec['sysctl-restart'];
  }
}
