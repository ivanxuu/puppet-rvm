define rvm::rvmuser (
  $installdefaultruby = false,
  $homeuser = "/home/$name",
  $rvm_version = 'stable',
){

  include rvm::rvmreq
  include rvm
  include rvm::rubyreq

  exec{ "installrvm-$name":
    command => "/bin/bash --login -c 'curl -L https://get.rvm.io | bash -s ${rvm_version}'",
    user => "$name",
    unless => "/bin/bash --login -c 'type rvm |head -1|grep function '",
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    environment => ["HOME=$homeuser"],
    ;
  }

  #source "$HOME/.rvm/scripts/rvm"
  if $installdefaultruby {
    rvm::installruby {"$user-$installdefaultruby":
      user => "$name",
      rubyversion => "$installdefaultruby",
      homeuser => $homeuser,
      makedefault => true,
      require => Exec["installrvm-$name"],
      ;
    }
  }

  if ! defined(User["$name"]) {
    user{ "$name":
        ensure => present,
        shell => "/bin/bash",
        home => "/home/$name",
        managehome => true,
        # groups => "www-data", # so we can set group to www-data to some dirs
        # password => '$6$L/PLguHR7copy_here_key_from_/etc/shadow_fileB/Hq1OQjNqafIUmXU/IJXoMXXCZEi.Ye48.M1ESCpu9vHjcEvuiKERJBW.',
        ;
    }
  }

  # Make sure the user exist,then install rvm requirements, then get install rvm, then ruby requirements
  User["$name"] -> Class["rvm::rvmreq"] -> Exec["installrvm-$name"] -> Class["rvm::rubyreq"] 

}

## Install rvm in username user
# rvm::rvmuser{"jhondoe":} # Install stable version of rvm for the user jhondoe, creates user if inexistent
# rvm::rvmuser{"jhondoe":
#   installdefaultruby => "2.0.0-head", # Optional Indicates the version that will be
#      #installed. Find available ruby versions with $rvm list known
#   homeuser => "/home/jhondoe", #defaults to /home/jhondoe(If jhondoe is the provided user)
# } 
