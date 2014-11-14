# Setting up misc configuration options
class celestial::config(
  $envs={},
  $ssh_key='',
  $cert_password='',
  $cert_keystore=''
){
  if($ssh_key!=''){
    file{'/root/.ssh':
      ensure => directory,
    } ->

    file{'/root/.ssh/id_rsa_celestial':
      ensure  => present
    } ->

    file_line { 'celestial key':
      path => '/root/.ssh/id_rsa_celestial',
      line => $ssh_key
    }
  }

  if($envs!={}) {
    file { '/etc/celestial/celestial.edn':
      ensure  => file,
      mode    => '0644',
      content => template('celestial/celestial.edn.erb'),
      owner   => root,
      group   => root,
      require => Package['celestial']
    }
  }
}
