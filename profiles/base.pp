
class base inherits bootstrap {

  if ! config_initialized {
    fail('Configuration system is required to install and manage the base profile.')
  }

  #-----------------------------------------------------------------------------
  # Properties

  #-----------------------------------------------------------------------------
  # Required systems

  include ntp
  include locales
  include nullmailer

  #-----------------------------------------------------------------------------
  # Optional systems

  coral_include('base_classes')

  #-----------------------------------------------------------------------------
  # Configurations

  #-----------------------------------------------------------------------------
  # Resources

}
