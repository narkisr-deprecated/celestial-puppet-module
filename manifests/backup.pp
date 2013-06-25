# backing up redis db to s3
class celestial::backup {

  backup::duply{'redis-backup':
    source       => '/var/lib/redis/',
    target       => hiera('s3::url'),
    target_user  => hiera('s3::user'),
    target_pass  => hiera('s3::pass'),
    tmp          => '/tmp',
    passphrase   => hiera('duply::passphrase')
  }

  backup::schedule {'redis-backup':
    hour        => '0',
    type        => 'duply',
  }

}
