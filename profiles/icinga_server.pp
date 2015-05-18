/**
 * Icinga2 server profile.
 */
class coralnexus::core::profile::icinga_server {

  $base_name = 'coralnexus_icinga_server'
  anchor { $base_name: }

  $database      = global_param('icinga_server_database', 'icinga2')
  $database_user = global_param('icinga_server_database_user', 'icinga2')

  #-----------------------------------------------------------------------------
  # Required systems

  if ! defined('coralnexus::core::profile::percona_server') {
    class { 'coralnexus::core::profile::percona_server':
      require => Anchor[$base_name]
    }
  }

  class { 'icinga2::server':
    server_db_type => 'mysql',
    db_host        => 'localhost',
    db_name        => $database,
    db_user        => $database_user
  }

  #-----------------------------------------------------------------------------
  # Resources

  corl::definitions { 'icinga_server::database':
    type      => 'percona::database',
    resources => {
      icinga => {
        ensure       => 'present',
        database     => $database,
        user_name    => $database_user,
        permissions  => 'ALL',
        grant        => false,
        allow_remote => false,
        notify       => Class['icinga2::server::install::execs']
      }
    },
    defaults => {
      require => [ Anchor[$base_name], Class['coralnexus::core::profile::percona_server'] ]
    }
  }

  #---

  corl::definitions { 'icinga_server::idomysqlconnection':
    type      => 'icinga2::object::idomysqlconnection',
    resources => {
      icinga_db_connection => {
        target_dir       => '/etc/icinga2/features-available',
        target_file_name => 'ido-mysql.conf',
        host             => 'localhost',
        database         => $database,
        user             => $database_user,
        categories       => [
          'DbCatConfig',
          'DbCatState',
          'DbCatAcknowledgement',
          'DbCatComment',
          'DbCatDowntime',
          'DbCatEventHandler'
        ],
        require => Class['icinga2::server']
      }
    }
  }
}
