/**
 * Icinga2 server profile.
 */
class coralnexus::core::profile::icinga_server {

  $base_name = 'coralnexus_icinga_server'
  anchor { $base_name: }

  #-----------------------------------------------------------------------------
  # Required systems

  if ! defined('coralnexus::core::profile::percona_server') {
    class { 'coralnexus::core::profile::percona_server': }
  }

  class { 'icinga2::server':
    server_db_type => 'mysql',
    db_host        => 'localhost',
    require        => Percona::Database['icinga_database']
  }

  #-----------------------------------------------------------------------------
  # Resources

}
