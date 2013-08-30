file { 'c:/before.txt':
  content   => 'one',
  before    => File['c:/after.txt']
}

reboot { 'reboot_now':
  message => "Rebooting yo",
  timeout => 2,

}

reboot { 'reboot_pending':
  message => "Rebooting pending",
  when => pending,
  timeout => 2,

}

file { 'c:/after.txt':
  content   => 'two',
  notify => Reboot['reboot_now']
}

file { 'c:/afterreboot.txt':
  content => 'yep',
  #subscribe => Reboot['reboot_now']
}

package { 'putty':
  ensure => installed,
  provider => 'chocolatey',
  source => 'c:\vagrant\resources\packages',
}