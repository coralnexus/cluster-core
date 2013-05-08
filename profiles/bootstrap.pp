
class bootstrap {

  #-----------------------------------------------------------------------------
  # Properties

  $vagrant_user = global_param('vagrant_user')

  $cluster_source   = global_param('cluster_source')
  $cluster_revision = global_param('cluster_revision')
  $cluster_repo_dir = global_param('cluster_repo_dir')

  $post_update_commands = global_array('post_update_commands')

  #-----------------------------------------------------------------------------
  # Required systems

  include users
  include git

  #-----------------------------------------------------------------------------
  # Configuration

  if $::vagrant_exists {
    users::conf { $vagrant_user: }
  }

  #-----------------------------------------------------------------------------
  # Resources

  git::repo { $cluster_repo_dir:
    source               => $cluster_source,
    revision             => $cluster_revision,
    base                 => false,
    post_update_commands => $post_update_commands,
  }
}
