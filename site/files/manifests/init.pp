class files {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  file { '/etc/cron.allow':
    ensure => file,
  }
  file_line { 'allow root cron jobs':
    ensure => present,
    path   => '/etc/cron.allow',
    line   => 'root',
  }

  # Add a rule to cron.deny to den
  file_line { 'prevent cron jobs':
    ensure => present,
    path   => '/etc/cron.deny', 
    line   =>  '*',
  }

  # What concat resource is needed for this fragment to work?
  concat { '/etc/motd':
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  concat::fragment { 'motd header':
    target  => '/etc/motd',
    order   => '01',
    content => epp('files/motd_header.epp'),
  }

  files::motd { 'production warning':
    order   => 5,
    message =>  'This is a production machine. Please make changes in Puppet',
  }

  # Add a few fragments to be appended to /etc/motd


  }
