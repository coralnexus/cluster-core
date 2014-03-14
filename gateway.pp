
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
  
  anchor { 'gateway-init': }

  #-----------------------------------------------------------------------------
  # Initialization

  corl::include { 'corl':
    require => Anchor['gateway-init']
  }
  include corl::firewall::pre_rules
  include corl::firewall::post_rules

  #---

  if ! config_initialized {
    notice "Bootstrapping server"
  }
  
  # Attach profiles here...
  anchor { 'gateway-exit': require => Class['corl'] }
}
