# including this until PR50 is present
# https://github.com/puppetlabs/puppetlabs-accounts/pull/51
define accounts::group(
  $ensure               = 'present',
  $gid                  = undef,
) {
  validate_re($ensure, '^(present|absent)$')

  if $gid != undef {
    validate_re($gid, '^\d+$')
    $_gid = $gid
  } else {
    $_gid = $name
  }

  group { $name:
    ensure => $ensure,
    gid    => $_gid,
  }
}

# temporary test
#file_line { 'sudonopw_rules':
#  path => '/etc/sudoers',
#  line => '%sudonopw ALL=NOPASSWD: ALL'
#}