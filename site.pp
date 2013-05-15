/**
 * Gateway manifest to all Puppet classes.
 *
 * Note: This is the only node in this system.  We use it to dynamically
 * bootstrap or load and manage classes (profiles).
 *
 * This should allow the server to configure it's own profiles in the future.
 */
node default {

  Exec {
    logoutput => 'on_failure',
  }

  #-----------------------------------------------------------------------------
  # Defaults

  import 'default.pp'
  import 'default/*.pp'
  include global::default

  #---

  $base_name = 'site'

  #-----------------------------------------------------------------------------
  # Initialization

  global_options('all', {
    search => [ 'global::default' ]
  })

  #---

  resources { "firewall":
    purge => true
  }
  Firewall {
    before  => Class['coral::firewall::post_rules'],
    require => Class['coral::firewall::pre_rules'],
  }

  include coral
  include coral::firewall::pre_rules
  include coral::firewall::post_rules

  Class['global::default'] -> Class['coral']

  Exec {
    user => $coral::params::exec_user,
    path => $coral::params::exec_path
  }

  #-----------------------------------------------------------------------------
  # Specialization

  import 'profiles/*.pp'

  if ! ( config_initialized and file_exists(global_param('config_common')) ) {
    $cluster_address = global_param('cluster_address')

    notice 'Bootstrapping server'
    notice "Push cluster definition to: ${cluster_address}"
  }

  #---

  $base_class = global_param('base_profile', 'base')

  class { $base_class:
    require => Class['coral']
  }
  coral::include { 'profiles':
    require => Class[$base_class]
  }
}
