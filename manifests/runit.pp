# Celestial docker setup
class celestial::runit{
  include redis::runit

  file{'/etc/service/celestial':
    ensure => directory,
  } ->

  file { '/etc/service/celestial/run':
    ensure=> file,
    mode  => 'u+x',
    source=> 'puppet:///modules/celestial/celestial_run',
    owner => root,
    group => root,
  }


}
