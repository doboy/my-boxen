class projects::osx {
  include osx::dock::autohide # - automatically hide the dock
  include osx::keyboard::capslock_to_control # - change caps-lock -> ctrl
  include osx::no_network_dsstores # disable creation of .DS_Store files on network drives.
  osx::recovery_message { 'Stolen from Huan, please call 714-417-5062': }
}
