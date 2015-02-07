/**
 * Basic high availability server profile (that's the goal anyway).
 */
class coralnexus::core::profile::base {

  $base_name = 'coralnexus_base'
  anchor { $base_name: }

  #-----------------------------------------------------------------------------
  # Properties

  $vagrant_user = global_param('vagrant_user')

  #-----------------------------------------------------------------------------
  # Required systems

  class { 'users': require => Anchor[$base_name] }
  class { 'git': require => Class['users'] }

  if $::virtual != 'docker' {
    class { 'ntp': require => Anchor[$base_name] }
  }
  class { 'locales': require => Anchor[$base_name] }
  class { 'nullmailer': require => Anchor[$base_name] }

  class { 'xinetd': require => Anchor[$base_name] }
  class { 'haproxy': require => Anchor[$base_name] }

  class { 'icinga2::nrpe': require => Anchor[$base_name] }

  #-----------------------------------------------------------------------------
  # Optional systems

  corl::include { 'base_classes':
    require => Anchor[$base_name]
  }

  #-----------------------------------------------------------------------------
  # Configuration

  if $::vagrant_exists {
    users::conf { $vagrant_user: }
  }

  #-----------------------------------------------------------------------------
  # Resources

  corl_resources('icinga2::checkplugin', 'icinga2::checkplugin', 'icinga2::checkplugin_defaults')
}
