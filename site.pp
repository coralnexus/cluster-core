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

  if config_initialized and file_exists(global_param('config_common')) {
    include base
    Class['coral'] -> Class['base']

    coral_include('profiles')
  }
  else {
    $cluster_address = global_param('cluster_address')

    notice 'Bootstrapping server'
    notice "Push cluster definition to: ${cluster_address}"

    include bootstrap
    Class['coral'] -> Class['bootstrap']
  }

  #-----------------------------------------------------------------------------
  # Logging

  $property_owner     = global_param('property_owner', 'root')
  $property_group     = global_param('property_group', 'admin')
  $property_dir_mode  = global_param('property_dir_mode', '0744')
  $property_file_mode = global_param('property_file_mode', '0744')

  #---

  # No configurations should be declared after this resource group.
  coral::file { $base_name:
    resources => {
      log_dir => {
        path => global_param('property_dir'),
        ensure => 'directory',
        owner  => $property_owner,
        group  => $property_group,
        mode   => $property_dir_mode
      },
      properties => {
        path    => global_param('property_path'),
        content => render(global_param('json_template', 'JSON'), configuration()),
        ensure  => 'present',
        owner   => $property_owner,
        group   => $property_group,
        mode    => $property_file_mode,
        require => 'log_dir'
      }
    }
  }
}
