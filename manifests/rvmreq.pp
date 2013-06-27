class rvm::rvmreq {

  # Required packages for rvm
  if ! defined(Package['curl'])                 { package { 'curl':                 ensure => installed } }
  if ! defined(Package['bash'])                 { package { 'bash':                 ensure => installed } }
  if ! defined(Package['git'])                 { package { 'git':                 ensure => installed } }
  if ! defined(Package['patch'])                 { package { 'patch':                 ensure => installed } }
  if ! defined(Package['bzip2'])                 { package { 'bzip2':                 ensure => installed } }
  
}
