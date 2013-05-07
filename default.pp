/**
 * Hiera default configurations.
 *
 * These configurations are used as a last resort in puppet nodes and classes
 * in this manifest directory.
 */
class global::default {
  include coral::params
  include git::params

  #---

  include global::default::coral
  include global::default::users
  include global::default::git

  #---

  # Vagrant user MUST be "vagrant" right now due to the vagrant_exists fact checking for user name.
  $vagrant_user = 'vagrant'

  #---

  $git_user     = $git::params::user
  $git_password = $git::params::password
  $git_home_dir = $git::params::home_dir

  #---

  $config_repo          = 'config.git'
  $config_repo_dir      = "${git_home_dir}/${config_repo}"

  $config_address       = "${git_user}@${::fqdn}:${config_repo}"
  $config_common        = "${config_repo_dir}/common.json"

  #---

  $puppet_source        = 'git://github.com/coralnexus/puppet-cluster.git'
  $puppet_revision      = 'master'

  $puppet_repo          = 'puppet.git'
  $puppet_repo_dir      = "${git_home_dir}/${puppet_repo}"

  $post_update_commands = [ $coral::params::puppet::update_command ]
}


