/**
 * PHP language.
 */
class coralnexus::core::profile::php {

  $base_name = 'coralnexus_php'
  anchor { $base_name: }

  #-----------------------------------------------------------------------------
  # Required systems

  class { '::php': require => Anchor[$base_name] }

  class { 'php::mod::mysql': require => Class['::php'] }

  #-----------------------------------------------------------------------------
  # Optional systems

  corl::include { 'php_classes': require => Class['::php'] }

  #-----------------------------------------------------------------------------
  # Resources

  corl_resources('php::conf', 'php::conf', 'php::conf_defaults')
  corl_resources('php::module', 'php::module', 'php::module_defaults')
}
