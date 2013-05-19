# A module which sets up a celestial instance
class celestial($repo_url='') {

  include jdk

  service{'celestial':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => [Package['celestial'], Service['redis-server']]
  }

  class{ 'redis':
    append => true
  }

  apt::key {'celestial':
    key        => '4BFCD8F9',
    key_source => "${repo_url}/celestialops.gpg"
  } ->

  apt::source { 'celestial':
    location    => $repo_url,
    release     => 'quantal',
    repos       => 'main',
    key         => '4BFCD8F9',
    key_source  => "${repo_url}/celestialops.gpg",
    include_src => false,
  } ->

  package{'celestial':
    ensure  => present
  }

}
