/**
 * Hiera default configurations.
 *
 * These configurations are used as a last resort in puppet nodes and classes
 * in this manifest directory.
 */
class core::default {

  # Vagrant user MUST be "vagrant" right now due to the vagrant_exists fact checking for user name.
  $vagrant_user = 'vagrant'

  #---

  $git_user     = 'git'
  $git_password = '$1$Sdrzl82I$Jen2/y4jvuCIWr69TgSGk.' # > gityup
  $git_home_dir = '/var/git'

  #---

  $cloud_source       = undef
  $cloud_revision     = 'master'

  $cloud_repo         = 'cloud.git'
  $cloud_repo_dir     = "${git_home_dir}/${cloud_repo}"

  $cloud_address      = "${git_user}@${::fqdn}:${cloud_repo}"
  $config_common      = "${cloud_repo_dir}/config/common.json"

  #---

  include core::default::coral
  include core::default::git
}


