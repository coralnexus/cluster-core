
class global::default::coral inherits global::default {

  include coral::default

  #---

  $puppet_dir = "${global::default::cluster_repo_dir}/puppet"
  $config_dir = "${global::default::cluster_repo_dir}/config"

  #---

  $facts = {
    'server_identity' => 'test',
    'server_stage'    => 'bootstrap',
    'server_type'     => 'core'
  }

  #---

  $puppet_config = {
    main => {
      modulepath  => join([ "${puppet_dir}/modules" ], ':'),
      manifestdir => $puppet_dir,
      manifest    => "${puppet_dir}/site.pp",
      templatedir => "${puppet_dir}/templates"
    }
  }

  $hiera_json_backend = {
    'type'    => 'json',
    'datadir' => $config_dir
  }
  $hiera_hierarchy = [
    "identity/%{::server_identity}/%{::server_stage}",
    "identity/%{::server_identity}",
    "server/%{::server_environment}/%{::server_location}/%{::hostname}/%{::server_stage}",
    "server/%{::server_environment}/%{::server_location}/%{::hostname}",
    "server/%{::server_environment}/%{::hostname}/%{::server_stage}",
    "server/%{::server_environment}/%{::hostname}",
    "server/%{::hostname}/%{::server_stage}",
    "server/%{::hostname}",
    "location/%{::server_location}/%{::server_stage}",
    "location/%{::server_location}",
    "environment/%{::server_environment}/%{::server_stage}",
    "environment/%{::server_environment}",
    "stage/%{::server_stage}",
    "type/%{::server_type}",
    "common"
  ]

  #---

  $ssh_config = {
    'Port'                   => 22,
    'PermitRootLogin'        => 'yes',
    'PermitEmptyPasswords'   => 'yes',
    'PasswordAuthentication' => 'yes',
    'AllowGroups'            => undef,
    'AllowUsers'             => ensure($::vagrant_exists, [ 'root', 'git', 'vagrant' ], [ 'root', 'git' ])
  }

  #---

  $sudoers_config = {
    'specs' => {
      '%admin' => 'ALL=(ALL) NOPASSWD:ALL',
      '%git'   => "ALL=NOPASSWD:${coral::default::puppet_bin}"
    }
  }
}
