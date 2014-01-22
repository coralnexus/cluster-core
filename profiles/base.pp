/**
 * Basic high availability server profile.
 */
class base {

  $base_name = 'base'
  anchor { $base_name: }

  #-----------------------------------------------------------------------------
  # Properties

  $vagrant_user = global_param('vagrant_user')

  $cloud_source   = global_param('cloud_source')
  $cloud_revision = global_param('cloud_revision')
  $cloud_repo     = global_param('cloud_repo')

  $cloud_update_commands = global_array('cloud_update_commands', [ $coral::params::puppet::update_command ])

  #-----------------------------------------------------------------------------
  # Required systems

  class { 'users': require => Anchor[$base_name] }
  class { 'git': require => Class['users'] }

  class { 'ntp': require => Anchor[$base_name] }
  class { 'locales': require => Anchor[$base_name] }
  class { 'nullmailer': require => Anchor[$base_name] }

  class { 'xinetd': require => Anchor[$base_name] }
  class { 'haproxy': require => Anchor[$base_name] }

  #-----------------------------------------------------------------------------
  # Optional systems

  coral::include { 'base_classes':
    require => Anchor[$base_name]
  }

  #-----------------------------------------------------------------------------
  # Configuration

  if $::vagrant_exists {
    users::conf { $vagrant_user: }
  }

  #-----------------------------------------------------------------------------
  # Resources

  git::repo { $cloud_repo:
    source               => $cloud_source,
    revision             => $cloud_revision,
    base                 => false,
    post_update_commands => $cloud_update_commands
  }
}
