class pushfacts(
  String $purpose,
  String $tier,
  String $org_email,
  String $org_group,
) {

  file {
    '/etc/puppetlabs/facter/facts.d/push.txt':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('elbase/push.txt'),
      require => File['/etc/puppetlabs/facter/facts.d'],
  }

  file {
    '/etc/puppetlabs/facter/facts.d':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => File['/etc/puppetlabs/facter'],
  }
  file {
    '/etc/puppetlabs/facter':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
  }

}
