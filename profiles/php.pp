/**
 * PHP language.
 */
class coralnexus::core::profile::php {

  $base_name = 'coralnexus_php'
  anchor { $base_name: }

  #-----------------------------------------------------------------------------
  # Required systems

  class { '::php': require => Anchor[$base_name] }

  if defined(Class['apache']) {
    include php::apache

    a2mod { 'php5':
      require => Class['php::apache'],
    }
  }

  include php::mod::mysql

  #-----------------------------------------------------------------------------
  # Optional systems

  if defined(Class['apache']) {
    corl::include { 'php_classes': require => A2mod['php5'] }
  } else {
    corl::include { 'php_classes': require => Class['::php'] }
  }

  #-----------------------------------------------------------------------------
  # Resources

  corl_resources('php::conf', 'php::conf', 'php::conf_defaults')
  corl_resources('php::module', 'php::module', 'php::module_defaults')
}
