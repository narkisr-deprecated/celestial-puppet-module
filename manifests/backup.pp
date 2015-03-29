# Backing up redis db to s3
class celestial::backup(
  $key        = false,
  $secret     = false,
  $bucket     = false,
  $passphrase = false,
){

  backup::duply{'redis-backup':
    source      => '/var/lib/redis/',
    target      => $bucket,
    target_user => $key,
    target_pass => $secret,
    passphrase  => $passphrase,
    globs       => ''
  }

  backup::duply::schedule {'redis-backup': }

}
