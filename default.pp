
class coralnexus::core::default {
  # Vagrant user MUST be "vagrant" right now due to the vagrant_exists fact checking for user name.
  $vagrant_user = 'vagrant'

  $php_classes = [
    "php::mod::intl",
    "php::mod::apc",
    "php::mod::curl",
    "php::mod::gd",
    "php::mod::imagick",
    "php::mod::xmlrpc",
    "php::mod::uploadprogress",
    "php::mod::xdebug"
  ]
}
