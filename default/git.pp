
class global::default::git inherits global::default {

  include git::default

  #---

  $user     = $global::default::git_user
  $password = $global::default::git_password
  $home_dir = $global::default::git_home_dir
}
