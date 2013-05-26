# A module which sets up a celestial instance
class celestial(
  $repo_url='http://celestial-ops.com/ubuntu',
  $key_id='E29035F0',
  $key_url = 'http://keyserver.ubuntu.com:11371/pks/lookup?op=get&fingerprint=on&search=0x8B095396E29035F0'
) {

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
    key        => $key_id,
    key_source => $key_url 
  } ->

  apt::source { 'celestial':
    location    => $repo_url,
    release     => 'quantal',
    repos       => 'main',
    key         => $key_id,
    key_source  => $key_url,
    include_src => false,
  } ->

  package{'celestial':
    ensure  => present
  }

}
