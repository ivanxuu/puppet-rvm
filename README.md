Puppet module to install rvm in a per user basis
=========================================================================
For an isolated install within a user's $HOME, not for root. Recomended by
wayneeseguin in https://rvm.io/rvm/install

NOTE: not really tested so far. For me it works in ubuntu 12.04LTS. Used in puppet 2.7 but it should also work in recent versions

Install rvm in jhondoe user
------------------------------------------------------------------------
It won't install any ruby, just rvm.
NOTE: User jhondoe will be created if doesn't exist
```ruby
rvm::rvmuser{"jhondoe":} # Install stable version of rvm for the user jhondoe, creates user if inexistent
```

Install rvm in jhondoe user and also install ruby version 2.0.0-head
------------------------------------------------------------------------
Installing and compilling any ruby version can take a while (>400seconds?)
The ruby version will be the default for this user
```ruby
rvm::rvmuser{"jhondoe":
  installdefaultruby => "2.0.0-head", # Optional Indicates the version that will be
     #installed. Find available ruby versions with $rvm list known
  homeuser => "/home/jhondoe", #defaults to /home/jhondoe(If jhondoe is the provided user)
} 
```

Install ruby version 2.0.0-head and make it as default ruby version
------------------------------------------------------------------------
```ruby
rvm::installruby{"install-ruby-to-jhondoe":
  user => 'jhondoe', #required
  rubyversion => "2.0.0-head", #required
  makedefault => true, #defaults to false
  homeuser = "/home/jhondoe", # Optional, defaults to /home/$user
}
```

Create a new gemset called gemsetname
------------------------------------------------------------------------
```ruby
rvm::creategemset{"gemsetname":
  user => "jhondoe", # user param is required
  rubyversion => "2.0.0", # Ruby version is required
  homeuser = "/home/jhondoe", # Optional, defaults to /home/$user
} 
```
Remember that a gemset is usually used to switch to a ruby
version and a set of gems. In a directory, if you write a file called .ruby-gemset with
the content "gemsetname" and a file called .ruby-version with the content
"ruby-1.9.3-p374" rvm will automatically switch to that ruby version with
the gemset called 'gemsetname' when you enter in that dir.
More info about this in [rvm website](https://rvm.io/gemsets)
