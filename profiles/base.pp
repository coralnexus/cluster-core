
class base inherits bootstrap {

  if ! config_initialized {
    fail('Configuration system is required to install and manage the base profile.')
  }

  #-----------------------------------------------------------------------------
  # Configurations

  #-----------------------------------------------------------------------------
  # Required systems

  include ntp
  include locales

  #-----------------------------------------------------------------------------
  # Optional systems

  coral_include('base_classes')

  #-----------------------------------------------------------------------------
  # Resources

}
