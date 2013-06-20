/**
 * Hiera default configurations.
 *
 * These configurations are used as a last resort in puppet nodes and classes
 * in this manifest directory.
 */
class coral_base::default {

  # Vagrant user MUST be "vagrant" right now due to the vagrant_exists fact checking for user name.
  $vagrant_user = 'vagrant'

  #---

  $git_user     = 'git'
  $git_password = '$1$Sdrzl82I$Jen2/y4jvuCIWr69TgSGk.' # > gityup
  $git_home_dir = '/var/git'

  #---

  $cluster_source       = undef
  $cluster_revision     = 'master'

  $cluster_repo         = 'cluster.git'
  $cluster_repo_dir     = "${git_home_dir}/${cluster_repo}"

  $cluster_address      = "${git_user}@${::fqdn}:${cluster_repo}"
  $config_common        = "${cluster_repo_dir}/config/common.json"
}


