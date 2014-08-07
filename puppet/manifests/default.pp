package { 'haskell-platform':
  ensure => installed
}

package { 'apache2':
  ensure => installed
}

package { 'postgresql-9.3':
  ensure => installed
}

package { 'rbenv':
  ensure => installed
}

package { 'emacs24':
  ensure => installed
}

package { 'git':
  ensure => installed
}

user { "jg":
  ensure     => "present",
  managehome => true,
  shell      => "/bin/bash"
}

file { "/home/jg/software":
    ensure => "directory",
    owner  => "jg"
}

file { "/home/jg/workplace":
    ensure => "directory",
    owner  => "jg"
}

vcsrepo { "/home/jg/.emacs.d":
  ensure   => present,
  provider => git,
  source   => "https://github.com/jg/.emacs.d.git"
}

vcsrepo { "/home/jg/software/dotfiles":
  ensure   => present,
  provider => git,
  source   => "https://github.com/jg/dotfiles.git"
}

exec { "setup dotfiles":
  command => "/home/jg/software/dotfiles/setup",
  creates => "/home/jg/.bashrc",
  user    => "jg"
}

include ssh_keys

ssh_keys::user{ 'jg':
  manage_ssh_dir => true,
}

ssh_keys::authorized_key{'jg-x200s':
  key_line => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHKrHIAXwsc4KBW2RjoWrgKBWeu96k3Dec7QIFn/qsh4GH7Xr6dCP5FsfDXzaoKPVC6serlJrIA0+yXqvZvZ5RL2s4qD7OYH87bfSmiXHEpNAOKCUQQkwJppmZ+0Qkgrvd7d9VEx/yA0A84hHkrNU/dGKQEGK5z73lTpOiSnmzvZbQTpFpZkwrhNQDr1hlBUELDSP4kZxWAGQo0MWqQHaMv7CVd8XOgTv5A5HA/GssVX5Wo2wVgGAT+1gOH4BOOE7nt+aNKix8uhP/0GSBvjCAM+hSTwbhnU+4OmreM5TKgXlUJHPH4Xrps9H1UWa2Z09C9PKCendkcPB4MFSRRcxn jg@jg-ThinkPad-x200s',
  user     => 'jg',
}
