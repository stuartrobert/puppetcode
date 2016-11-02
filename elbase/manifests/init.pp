class elbase {
# RHEL / CentOS misc profile mainly for EL7
#
# add some basic packages and remove some we don't use
# disable ipv6 bits: netconfig, clean /etc/hosts
# tidy /etc/skel
# shut rsyslogd up about slices and session
# fix permissions on unit files from packages shipped with EL to remove warnings
# don't run kdump 
# make sure rsyslog is running

  package {
    # INSTALL:
    'mailx': ensure => latest;
    'lsscsi': ensure => latest;
    'bzip2': ensure => latest;
    'parted': ensure => latest;
    'pciutils': ensure => latest;
    'sos': ensure => latest;
    'man-pages': ensure => latest;
    'augeas': ensure => latest;
    'scl-utils': ensure => latest;
    'dmidecode': ensure => latest;
    'sg3_utils': ensure => latest;

    # REMOVE:
    'teamd': ensure => absent;
    'libteam': ensure => absent;
    'NetworkManager-team': ensure => absent;
  }

  file {
    'netconfig':
      path   => '/etc/netconfig',
      source => 'puppet:///modules/elbase/netconfig',
      owner  => 'root',
      group  => 'root',
      mode   => '0644';

    '/etc/modprobe.d/disabled.conf':
      ensure => absent;
  }

  tidy { '/etc/skel':
    recurse => 1,
    matches => '*',
  }

  if $::operatingsystemmajrelease + 0 >= 7 {

    file {
    # shut stupid systemd messages up
    # see Redhat solution: https://access.redhat.com/solutions/1564823
    'ignore-systemd-session-slice':
        path   => '/etc/rsyslog.d/ignore-systemd-session-slice.conf',
        source => 'puppet:///modules/elbase/ignore-systemd-session-slice.conf',
        mode   => '0644',
        notify => Service['rsyslog'];

    'ignore-systemd-login-session':
        path   => '/etc/rsyslog.d/ignore-systemd-login-session.conf',
        source => 'puppet:///modules/elbase/ignore-systemd-login-session.conf',
        mode   => '0644',
        notify => Service['rsyslog'];

    'listen.conf':
        path   => '/etc/rsyslog.d/listen.conf',
        source => 'puppet:///modules/elbase/rsyslog-listen.conf',
        mode   => '0644',
        notify => Service['rsyslog'];

      # fix permissions on this file to stop systemd complaining
      'wpa_supplicant.service':
        path   => '/usr/lib/systemd/system/wpa_supplicant.service',
        mode   => '0644';

      # fix permissions on this file to stop systemd complaining
      'auditd.service':
        path   => '/usr/lib/systemd/system/auditd.service',
        mode   => '0644';
    }

    service {
      'wpa_supplicant':
        ensure => stopped,
        enable => false;
      'NetworkManager':
        ensure => stopped,
        enable => false;
    #  'polkit':
    #    ensure => stopped,
    #    enable => false;
    }

  } else { # assume EL6

  }

  service {
    'rsyslog':
      enable => true,
      ensure => running;
    'kdump':
      ensure => stopped,
      enable => false;
  }

  augeas {
    'initcfg':
      context => '/files/etc/sysconfig/init',
      changes => 'set PROMPT no';
    'ipv6localhost':
      context => '/files/etc/hosts',
      changes => 'rm *[ipaddr = "::1"]';
  }

}
