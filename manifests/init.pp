# Class: wpython
# ===========================
#
# wpython installs Python for Windows
#
# Parameters
# ----------
# * `version`
# Designate the version of Python you wish to install. Note that revision number should be 0, if there is no revision.
# i.e. 3.4.0 is the correct way, as opposed to 3.4
# Defaults to 2.7.12
#
# * `downloaddirectory`
# Designate a directory to download Python installation files to
# This is only required for version of python installed using .exe
# Defaults to C:\pythonfiles (a directory will be created if path does not exist)
#
# * `uninstall`
# Set to true, or false. It tells the module whether you are looking to uninstall or install python.
# Defaults to false (installation mode)
#
# Examples
# --------
#
# @example1
# class { "wpython":
#   version           => '2.7.12',
#   downloaddirectory => 'C:\downloads',
#   uninstall         => 'false',
# }
# @example2
# include wpython
#
# Authors
# -------
#
# Kevin Chang <kevin.chang@hpe.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#

class wpython (

  $version           = $wpython::params::version,
  $downloaddirectory = $wpython::params::downloaddirectory,
  $uninstall         = $wpython::params::uninstall,


) inherits wpython::params {

  if ($python_version != $version or $uninstall) {
    include wpython::install
  }
  
}
