/**
 * Hiera default configurations.
 *
 * These configurations are used as a last resort in puppet nodes and classes
 * in this manifest directory.
 */
class global::default {
  $git_init_password = '' # No password (initially unless overriden in sub repo)

  $git_home          = '/var/git'

  $config_repo       = 'config.git'
  $config_repo_dir   = "${git_home}/${config_repo}"

  $config_address    = "git@${::fqdn}:${config_repo}"
  $config_common     = "${config_repo_dir}/common.json"

  $puppet_source     = 'git://github.com/coralnexus/puppet-cluster.git'
  $puppet_branch     = 'master'

  $puppet_repo     = 'puppet.git'
  $puppet_repo_dir = "${git_home}/${puppet_repo}"
}

# For the record, I hate doing this :-(
import "default/*.pp"
include global::default::coral
#include global::default::git
