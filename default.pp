/**
 * Hiera default configurations.
 *
 * These configurations are used as a last resort in puppet nodes and classes
 * in this manifest directory.
 */
class coral::default {
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

import "default/*.pp"
include coral::default::coral
#include coral::default::ruby
#include coral::default::puppet
#include coral::default::ssh
#include coral::default::sudo
#include coral::default::git
