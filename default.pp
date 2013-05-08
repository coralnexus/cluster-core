/**
 * Hiera default configurations.
 *
 * These configurations are used as a last resort in puppet nodes and classes
 * in this manifest directory.
 */
class global::default {

  include coral::params::puppet
  include git::params

  include global::default::coral

  #---

  # Vagrant user MUST be "vagrant" right now due to the vagrant_exists fact checking for user name.
  $vagrant_user = 'vagrant'

  #---

  $git_user     = $git::params::user
  $git_password = $git::params::password
  $git_home_dir = $git::params::home_dir

  #---

  $cluster_source       = undef
  $puppet_revision      = 'master'

  $cluster_repo         = 'cluster.git'
  $cluster_repo_dir     = "${git_home_dir}/${cluster_repo}"

  $cluster_address      = "${git_user}@${::fqdn}:${cluster_repo}"
  $config_common        = "${cluster_repo_dir}/config/common.json"

  #---

  $post_update_commands = [ $coral::params::puppet::update_command ]
}


