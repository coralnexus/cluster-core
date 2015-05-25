/**
 * Icinga2 client node installation / configuration
 */
class coralnexus::core::profile::icinga_client {

  $base_name = 'coralnexus_icinga_client'
  anchor { $base_name: }

  #-----------------------------------------------------------------------------
  # Properties

  #-----------------------------------------------------------------------------
  # Required systems

  class { 'icinga2::nrpe': require => Anchor[$base_name] }

  #-----------------------------------------------------------------------------
  # Optional systems

  corl::include { 'icinga_client_classes':
    require => Anchor[$base_name]
  }

  #-----------------------------------------------------------------------------
  # Configuration

  #-----------------------------------------------------------------------------
  # Resources

  corl_resources('icinga2::checkplugin', 'icinga2::checkplugin', 'icinga2::checkplugin_defaults')

  #---

  corl_resources('icinga2::object::apilistener', 'icinga2::object::apilistener', 'icinga2::object::apilistener_defaults')
  corl_resources('icinga2::object::apply_dependency', 'iicinga2::object::apply_dependency', 'icinga2::object::apply_dependency_defaults')
  corl_resources('icinga2::object::apply_notification_to_host', 'icinga2::object::apply_notification_to_host', 'icinga2::object::apply_notification_to_host_defaults')
  corl_resources('icinga2::object::apply_notification_to_service', 'icinga2::object::apply_notification_to_service', 'icinga2::object::apply_notification_to_service_defaults')
  corl_resources('icinga2::object::apply_service_to_host', 'icinga2::object::apply_service_to_host', 'icinga2::object::apply_service_to_host_defaults')
  corl_resources('icinga2::object::checkcommand', 'icinga2::object::checkcommand', 'icinga2::object::checkcommand_defaults')
  corl_resources('icinga2::object::checkercomponent', 'icinga2::object::checkercomponent', 'icinga2::object::checkercomponent_defaults')
  corl_resources('icinga2::object::checkresultreader', 'icinga2::object::checkresultreader', 'icinga2::object::checkresultreader_defaults')
  corl_resources('icinga2::object::compatlogger', 'icinga2::object::compatlogger', 'icinga2::object::compatlogger_defaults')
  corl_resources('icinga2::object::dependency', 'icinga2::object::dependency', 'icinga2::object::dependency_defaults')
  corl_resources('icinga2::object::endpoint', 'icinga2::object::endpoint', 'icinga2::object::endpoint_defaults')
  corl_resources('icinga2::object::eventcommand', 'icinga2::object::eventcommand', 'icinga2::object::eventcommand_defaults')
  corl_resources('icinga2::object::externalcommandlistener', 'icinga2::object::externalcommandlistener', 'icinga2::object::externalcommandlistener_defaults')
  corl_resources('icinga2::object::filelogger', 'icinga2::object::filelogger', 'icinga2::object::filelogger_defaults')
  corl_resources('icinga2::object::graphitewriter', 'icinga2::object::graphitewriter', 'icinga2::object::graphitewriter_defaults')
  corl_resources('icinga2::object::host', 'icinga2::object::host', 'icinga2::object::host_defaults')
  corl_resources('icinga2::object::hostgroup', 'icinga2::object::hostgroup', 'icinga2::object::hostgroup_defaults')
  corl_resources('icinga2::object::icingastatuswriter', 'icinga2::object::icingastatuswriter', 'icinga2::object::icingastatuswriter_defaults')
  corl_resources('icinga2::object::idomysqlconnection', 'icinga2::object::idomysqlconnection', 'icinga2::object::idomysqlconnection_defaults')
  corl_resources('icinga2::object::idopgsqlconnection', 'icinga2::object::idopgsqlconnection', 'icinga2::object::idopgsqlconnection_defaults')
  corl_resources('icinga2::object::livestatuslistener', 'icinga2::object::livestatuslistener', 'icinga2::object::livestatuslistener_defaults')
  corl_resources('icinga2::object::notification', 'icinga2::object::notification', 'icinga2::object::notification_defaults')
  corl_resources('icinga2::object::notificationcommand', 'icinga2::object::notificationcommand', 'icinga2::object::notificationcommand_defaults')
  corl_resources('icinga2::object::notificationcomponent', 'icinga2::object::notificationcomponent', 'icinga2::object::notificationcomponent_defaults')
  corl_resources('icinga2::object::perfdatawriter', 'icinga2::object::perfdatawriter', 'icinga2::object::perfdatawriter_defaults')
  corl_resources('icinga2::object::scheduleddowntime', 'icinga2::object::scheduleddowntime', 'icinga2::object::scheduleddowntime_defaults')
  corl_resources('icinga2::object::service', 'icinga2::object::service', 'icinga2::object::service_defaults')
  corl_resources('icinga2::object::servicegroup', 'icinga2::object::servicegroup', 'icinga2::object::servicegroup_defaults')
  corl_resources('icinga2::object::statusdatawriter', 'icinga2::object::statusdatawriter', 'icinga2::object::statusdatawriter_defaults')
  corl_resources('icinga2::object::sysloglogger', 'icinga2::object::sysloglogger', 'icinga2::object::sysloglogger_defaults')
  corl_resources('icinga2::object::timeperiod', 'icinga2::object::timeperiod', 'icinga2::object::timeperiod_defaults')
  corl_resources('icinga2::object::user', 'icinga2::object::user', 'icinga2::object::user_defaults')
  corl_resources('icinga2::object::usergroup', 'icinga2::object::usergroup', 'icinga2::object::usergroup_defaults')
}
