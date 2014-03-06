/**
 * Gateway manifest to all Puppet classes.
 *
 * Note: This is the only node in this system.  We use it to dynamically
 * bootstrap or load and manage classes (profiles).
 */

#--------------------------------------------------------------------------------
# Defaults

resources { "firewall":
  purge => true
}
Firewall {
  before  => Class['corl::firewall::post_rules'],
  require => Class['corl::firewall::pre_rules'],
}

include corl::params

Exec {
  user      => $corl::params::exec_user,
  path      => $corl::params::exec_path,
  logoutput => 'on_failure'
}

#--------------------------------------------------------------------------------
# Gateway

node default {

  #-----------------------------------------------------------------------------
  # Initialization

  include corl
  include corl::firewall::pre_rules
  include corl::firewall::post_rules

  Class['coralnexus::core::default'] -> Class['corl']

  #-----------------------------------------------------------------------------
  # Specialization

  if ! config_initialized {
    notice 'Bootstrapping server'
  }

  #---

  $base_profile = global_param('base_profile', 'coralnexus::core::profile::base')

  class { $base_profile: }
  corl::include { 'profiles': }
}
