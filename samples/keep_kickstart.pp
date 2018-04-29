# a kickstart template
class profile::keep_kickstart {

  kickstart { '/export/kickstart/centos7_example.ks':
    commands => {
      'install'    => true,
      'text'       => true,
      'reboot'     => false,
      'skipx'      => true,
      'url'        => '--url http://keep/repo/centos7-x86_64.iso',
      'lang'       => 'en_AU.UTF-8',
      'keyboard'   => '--vckeymap=us --xlayouts="us"',
      'network'    => '--device eth0 --bootproto dhcp',
      'rootpw'     => 'rhcsinst',
      'firewall'   => '--disabled',
      'selinux'    => '--permissive',
      'authconfig' => '--enableshadow',
      'timezone'   => 'Australia/Brisbane --isUtc --ntpservers=0.centos.pool.ntp.org,1.centos.pool.ntp.org,2.centos.pool.ntp.org,3.centos.pool.ntp.org',
      'bootloader' => '--location mbr',
      'firstboot'  => '--disable',
    },
    partition_configuration => {
      zerombr   => 'yes',
      clearpart => '--all --initlabel',
      part      => [
        '/boot --fstype xfs --size 512',
        'pv.2 --size 8192 --grow',
      ],
      volgroup  => 'rootvg --pesize 8000 pv.2',
      logvol    => [
        '/ --fstype xfs --name rootlv --vgname rootvg --size 6120 --grow',
        'swap --fstype swap --name swaplv --vgname rootvg --size 1024',
      ]
    },
    packages => [
      '@core',
      '@base',
      'unzip',
    ],
  }
}
