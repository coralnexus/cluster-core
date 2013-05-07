
class base inherits bootstrap {

  if ! config_initialized {
    fail('Configuration system is required to install and manage the base profile.')
  }

  #-----------------------------------------------------------------------------
  # Configurations

  #-----------------------------------------------------------------------------
  # Required systems

  coral_include('classes')

  #-----------------------------------------------------------------------------
  # Resources

}
