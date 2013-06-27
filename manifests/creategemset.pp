define rvm::creategemset (
  $user,
  $rubyversion,
  $homeuser = "/home/$user"
){

  # Create a gemset with the ruby version rubyversion
  exec { "/bin/bash --login -c 'rvm use $rubyversion && rvm gemset create $name'":
    unless => "/bin/bash --login -c 'HOME=$homeuser && type rvm |head -1|grep 'function' && rvm use $rubyversion && rvm gemset list|grep $name'",
    user => "$user",
    require => Class["rvm::rubyreq"], # So make sure rvm was installed
    environment => ["HOME=$homeuser"],
    ;
  }

}

# # Create Gemset for a project called gemsetname
# rvm::creategemset{"gemsetname":
#   user => "jhondoe", # user param is required
#   rubyversion => "2.0.0", # Ruby version is required
#   ;
# } 
