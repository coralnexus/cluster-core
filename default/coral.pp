
class coral::default::coral inherits coral::default {

  $facts = {
    'server_identity' => 'test',
    'server_stage'    => 'bootstrap',
    'server_type'     => 'core'
  }

  #---

  $puppet_config = {
    main => {
      modulepath  => join([ "${puppet_repo_dir}/modules" ], ':'),
      manifestdir => $puppet_repo_dir,
      manifest    => "${puppet_repo_dir}/site.pp",
      templatedir => "${puppet_repo_dir}/templates"
    }
  }

  $hiera_backends = [
    {
      'type'    => 'json',
      'datadir' => $config_repo_dir
    }
  ]
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
    'AllowGroups'            => [],
    'AllowUsers'             => $::vagrant_exists ? { true => [ 'root', 'git', 'vagrant' ], default => [ 'root', 'git' ] }
  }

  #---

  $sudoers_config = {
    'specs' => {
      '%admin' => 'ALL=(ALL) NOPASSWD:ALL',
      'git'    => "ALL=NOPASSWD:${coral::params::puppet_bin}"
    }
  }
}
