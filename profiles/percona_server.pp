/**
 * Percona database server profile.
 */
class coralnexus::core::profile::percona_server {

  $base_name = 'coralnexus_percona_server'
  anchor { $base_name: }

  #-----------------------------------------------------------------------------
  # Required systems

  class { 'percona':
    server  => true
  }

  #-----------------------------------------------------------------------------
  # Optional systems

  corl::include { 'percona_server_classes':
    require => Class['percona']
  }

  #-----------------------------------------------------------------------------
  # Resources

  corl_resources('percona::conf', 'percona::conf', 'percona::conf_defaults')
  corl_resources('percona::user', 'percona::user', 'percona::user_defaults')
  corl_resources('percona::database', 'percona::database', 'percona::database_defaults')
  corl_resources('percona::query', 'percona::query', 'percona::query_defaults')
}
