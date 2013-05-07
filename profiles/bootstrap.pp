
class bootstrap {

  #-----------------------------------------------------------------------------
  # Required systems

  include users
  include git

  #-----------------------------------------------------------------------------
  # Environment

  if $::vagrant_exists {
    users::conf { $global::default::vagrant_user: }
  }

  #---

  git::repo { $global::default::puppet_repo:
    source               => $global::default::puppet_source,
    revision             => $global::default::puppet_revision,
    base                 => false,
    post_update_commands => $global::default::post_update_commands,
  }

  git::repo { $global::default::config_repo:
    revision             => '',
    base                 => false,
    post_update_commands => $global::default::post_update_commands,
  }
}
