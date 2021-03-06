
class coralnexus::core::default::corl {

  $config_dir = "${::corl_network}/config"

  #---

  if ::vagrant_exists {
    # Can't change file info when NFS mounted (as the CORL log directory often is)
    $log_owner    = undef
    $log_group    = undef
    $log_dir_mode = undef
  }

  #---

  $puppet_config = {
    'main' => {
      'data_binding_terminus' => 'corl',
      'report'                => true,
      'reports'               => 'store',
      'hiera_config'          => undef
    }
  }

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

  $sshd_config = {
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
