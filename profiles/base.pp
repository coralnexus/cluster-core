
class base {

  #-----------------------------------------------------------------------------
  # Properties

  $vagrant_user = global_param('vagrant_user')

  $cluster_source   = global_param('cluster_source')
  $cluster_revision = global_param('cluster_revision')
  $cluster_repo     = global_param('cluster_repo')

  $post_update_commands = global_array('post_update_commands', [ $coral::params::puppet::update_command ])

  #-----------------------------------------------------------------------------
  # Required systems

  include users
  include git

  include ntp
  include locales
  include nullmailer

  #-----------------------------------------------------------------------------
  # Optional systems

  coral_include('base_classes')

  #-----------------------------------------------------------------------------
  # Configuration

  if $::vagrant_exists {
    users::conf { $vagrant_user: }
  }

  #-----------------------------------------------------------------------------
  # Resources

  git::repo { $cluster_repo:
    source               => $cluster_source,
    revision             => $cluster_revision,
    base                 => false,
    post_update_commands => $post_update_commands,
  }
}
