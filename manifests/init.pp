class basic::install {

  package { "linux-headers-$kernelrelease" :
    ensure => installed
  }
  
  package { "build-essential":
    ensure => installed
  }
  
  package { "vim" :
    ensure => installed
  }
  
  package { "ack":
    ensure => installed
  }

  package { "autoconf":
    ensure => installed
  }

}

class basic::config {
  exec { "set-max-open-files":
    command => "/sbin/sysctl -w fs.file-max=100000",
    unless => "cat /proc/sys/fs/file-max | grep -q 100000"
  }
  
  exec { "update-max-open-files":
    require => [ Exec['set-max-open-files'] ],
    command => "/sbin/sysctl -p"
  }
}

class basic {
  include basic::install, basic::config
}

