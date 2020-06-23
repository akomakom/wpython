class wpython::install inherits wpython {

  $version = $wpython::version
  $downloaddirectory = $wpython::downloaddirectory
  $uninstall = $wpython::uninstall

  #version comparison function used, returns 1 if first # larger, 0 if equal, -1 if first # smaller
  #takes strings
  if versioncmp('3.5', $version) <= 0 {
    $downloadurl = "https://www.python.org/ftp/python/${version}/python-${version}.exe"
    $localfile = "${downloaddirectory}/python-${version}.exe"
  } else {
    $downloadurl = "https://www.python.org/ftp/python/${version}/python-${version}.msi"
    $localfile = "${downloaddirectory}/python-${version}.msi"
  }

  case $::os['release']['major'] {
    '2012': {
      # does not support direct URL to package, download it locally first

      file { 'pythondirectory':
        ensure => directory,
        path   => "${downloaddirectory}",
      }

      #package resource for windows exes only support file system URIs, hence need to store a copy
      file { 'pythondownload':
        ensure => present,
        path   => $localfile,
        source => $downloadurl,
      }

      $packagefile = $localfile

    }
    default: {
      $packagefile = $downloadurl
    }
  }

  #version comparison function used, returns 1 if first # larger, 0 if equal, -1 if first # smaller
  #takes strings
  if versioncmp('3.5', $version) <= 0 {

    if $uninstall != true {

      #/i & /qn flags are automatically included.
      #installs 3.5+, it matters since python now uses .exe instead of .msi
      package { 'python35':
        ensure          => installed,
        source          => $packagefile,
        provider        => windows,
        install_options => ['/quiet', { 'InstallAllUsers' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
      }
    } else {
      package { "Python ${version} (32-bit)":
        ensure            => absent,
        source            => $packagefile,
        provider          => windows,
        uninstall_options => ['/uninstall', '/quiet'],
      }
    }

  } elsif versioncmp('3.0', $version) <= 0 {

    if $uninstall != true {

      #installs 3.0+
      package { 'python30':
        ensure          => installed,
        source          => $packagefile,
        provider        => windows,
        install_options => [{ 'ALLUSERS' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
      }
    } else {

      package { "Python ${version}":
        ensure            => absent,
        source            => $packagefile,
        provider          => windows,
        uninstall_options => [{ 'ALLUSERS' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
      }
    }
  } else {

    if $uninstall != true {
      #install 2.7
      package { 'python27':
        ensure          => installed,
        source          => $packagefile,
        provider        => windows,
        install_options => [{ 'ALLUSERS' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
      }
    } else {
      package { "Python ${version}":
        ensure            => absent,
        source            => $packagefile,
        provider          => windows,
        uninstall_options => [{ 'ALLUSERS' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
      }
    }
  }

}
