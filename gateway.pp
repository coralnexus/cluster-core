
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

  #---

  if ! config_initialized {
    notice 'Bootstrapping server'
  }
}
