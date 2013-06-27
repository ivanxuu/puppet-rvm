Puppet module to install rvm in a per user basis
=========================================================================
For an isolated install within a user's $HOME, not for root. Recomended by
wayneeseguin in https://rvm.io/rvm/install

Install rvm in jhondoe user
------------------------------------------------------------------------
NOTE: User jhondoe will be created if doesn't exist
```ruby
rvm::rvmuser{"jhondoe":} # Install stable version of rvm for the user jhondoe, creates user if inexistent
```

Install rvm in jhondoe user and also install ruby version 2.0.0-head as default ruby 
------------------------------------------------------------------------
```ruby
rvm::rvmuser{"jhondoe":
  installdefaultruby => "2.0.0-head", # Optional Indicates the version that will be
     #installed. Find available ruby versions with $rvm list known
  homeuser => "/home/jhondoe", #defaults to /home/jhondoe(If jhondoe is the provided user)
} 
```

Install rvm in jhondoe user and also install ruby version 2.0.0-head as default ruby 
------------------------------------------------------------------------
```ruby
rvm::installruby{"install-ruby-to-jhondoe":
  user => 'jhondoe', #required
  rubyversion => "2.0.0-head", #required
  makedefault => true, #defaults to false
  homeuser = "/home/jhondoe", # Optional, defaults to /home/$user
}
```

Create Gemset for a project called gemsetname
------------------------------------------------------------------------
```ruby
rvm::creategemset{"gemsetname":
  user => "jhondoe", # user param is required
  rubyversion => "2.0.0", # Ruby version is required
  homeuser = "/home/jhondoe", # Optional, defaults to /home/$user
} 
```


NOTE: not really tested so far. For me it works in ubuntu 12.04LTS. Used in puppet 2.7 but it should also work in recent versions
