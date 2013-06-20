/**
 * Gateway manifest to all Puppet classes.
 *
 * Note: This is the only node in the Coral system.  We use it to dynamically
 * bootstrap or load and manage classes (profiles).
 *
 * This should allow the server to configure it's own profiles in the future.
 */
#--------------------------------------------------------------------------------
# Defaults

resources { "firewall":
  purge => true
}
Firewall {
  before  => Class['coral::firewall::post_rules'],
  require => Class['coral::firewall::pre_rules'],
}

include coral::params

Exec {
  user      => $coral::params::exec_user,
  path      => $coral::params::exec_path,
  logoutput => 'on_failure'
}

#--------------------------------------------------------------------------------
# Gateway

node default {

  #-----------------------------------------------------------------------------
  # Initialization

  include coral
  include coral::firewall::pre_rules
  include coral::firewall::post_rules

  Class['coral_base::default'] -> Class['coral']

  #-----------------------------------------------------------------------------
  # Specialization

  if ! ( config_initialized and file_exists(global_param('config_common')) ) {
    $cluster_address = global_param('cluster_address')

    notice 'Bootstrapping server'
    notice "Push cluster definition to: ${cluster_address}"
  }

  #---

  $base_profile = global_param('base_profile', 'coral_base')

  class { $base_profile: }
  coral::include { 'profiles': }
}
