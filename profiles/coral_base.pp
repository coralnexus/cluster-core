/**
 * Basic high availability server profile.
 */
class coral_base {

  $base_name = 'base'
  anchor { $base_name: }

  #-----------------------------------------------------------------------------
  # Properties

  $vagrant_user = global_param('vagrant_user')

  $cluster_source   = global_param('cluster_source')
  $cluster_revision = global_param('cluster_revision')
  $cluster_repo     = global_param('cluster_repo')

  $cluster_update_commands = global_array('cluster_update_commands', [ $coral::params::puppet::update_command ])

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

  git::repo { $cluster_repo:
    source               => $cluster_source,
    revision             => $cluster_revision,
    base                 => false,
    post_update_commands => $cluster_update_commands
  }
}
