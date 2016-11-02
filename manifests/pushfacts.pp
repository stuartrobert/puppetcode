class pushfacts(
  String $purpose,
  String $tier,
  String $org_email,
  String $org_group,
) {
#
# This class pushes facts typically populated into this class from hiera to a node.
# Then on future node puppet runs, these facts are available.
# Useful for "pushing" data from puppet master to client
# Con: needs an initial run to populate data in fact dir first
# Pro: can also be used in shell scripts by sourcing the file
#
# Ref: https://docs.puppet.com/facter/3.4/custom_facts.html#structured-data-facts

  file {
    '/etc/puppetlabs/facter/facts.d/push.txt':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('elbase/pushfacts.txt'),
      require => File['/etc/puppetlabs/facter/facts.d'],
  }

  file {
    '/etc/puppetlabs/facter/facts.d':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => File['/etc/puppetlabs/facter'];

    '/etc/puppetlabs/facter':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755';
  }

}
