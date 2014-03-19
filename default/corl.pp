
class coralnexus::core::default::corl {

  $config_dir = "${::corl_network}/config"
  
  #---
  
  $puppet_config = {
    'main' => {
      'data_binding_terminus' => 'corl',
      'report'                => true,
      'reports'               => 'store',
      'hiera_config'          => undef
    }
  }
  
  $puppet_update_command = "sudo corl provision"

  #---

  $hiera_json_backend = {
    'type'    => 'json',
    'datadir' => $config_dir
  }
  $hiera_yaml_backend = {
    'type'    => 'yaml',
    'datadir' => $config_dir
  }
  $hiera_hierarchy = [
    "identities/${::corl_identity}/stages/${::corl_stage}",
    "identities/${::corl_identity}/identity",
    "nodes/${::corl_provider}/${::fqdn}/stages/${::corl_stage}",
    "nodes/${::corl_provider}/${::fqdn}/node",
    "environments/${::corl_environment}/stages/${::corl_stage}",
    "environments/${::corl_environment}/environment",
    "stages/${::corl_stage}",
    "types/${::corl_type}",
    "common"
  ]

  #---

  $ssh_config = {
    'Port'                   => 22,
    'PermitRootLogin'        => 'yes',
    'PermitEmptyPasswords'   => 'no',
    'PasswordAuthentication' => 'yes',
    'AllowGroups'            => undef,
    'AllowUsers'             => ensure($::vagrant_exists, [ 'root', 'git', 'vagrant' ], [ 'root', 'git' ])
  }

  #---

  $sudoers_config = {
    'specs' => {
      '%admin' => 'ALL=(ALL) NOPASSWD:ALL'
    }
  }
}
