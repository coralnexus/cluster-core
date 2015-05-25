/**
 * Zabbix client node installation / configuration
 */
class coralnexus::core::profile::zabbix_client {

  $base_name = 'coralnexus_zabbix_client'
  anchor { $base_name: }

  #-----------------------------------------------------------------------------
  # Properties

  #-----------------------------------------------------------------------------
  # Required systems

  class { 'zabbix::client': require => Anchor[$base_name] }

  #-----------------------------------------------------------------------------
  # Optional systems

  corl::include { 'zabbix_client_classes':
    require => Anchor[$base_name]
  }

  #-----------------------------------------------------------------------------
  # Configuration

  #-----------------------------------------------------------------------------
  # Resources
}
