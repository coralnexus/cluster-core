
class bootstrap {

  #-----------------------------------------------------------------------------
  # Properties

  $vagrant_user         = global_param('vagrant_user')

  $puppet_repo_dir      = global_param('puppet_repo_dir')
  $puppet_source        = global_param('puppet_source')
  $puppet_revision      = global_param('puppet_revision')
  $post_update_commands = global_array('post_update_commands')

  $config_repo_dir      = global_param('config_repo_dir')

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

  git::repo { $puppet_repo_dir:
    source               => $puppet_source,
    revision             => $puppet_revision,
    base                 => false,
    post_update_commands => $post_update_commands,
  }

  git::repo { $config_repo_dir:
    revision             => '',
    base                 => false,
    post_update_commands => $post_update_commands,
  }
}
