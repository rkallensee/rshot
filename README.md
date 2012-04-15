rshot
=====

[![Build Status](https://secure.travis-ci.org/rkallensee/rshot.png?branch=master)](http://travis-ci.org/rkallensee/rshot) [![Dependency Status](https://gemnasium.com/rkallensee/rshot.png?travis)](https://gemnasium.com/rkallensee/rshot)

rshot is a social digital photo gallery software written in Ruby. It should make
it easy to publish your digital photos and make them easily browseable by anyone.


Status
------

rshot is under heavy development. Currently it should be considered as nothing more
than a quick hack. *It's not safe to use it in production environments yet!*


Installation (local)
----------------------

For production you should set up and configure a Passenger/Apache, Thin/Nginx, Mongrel
or similar setup - you can find more about these setups in the interwebs. This is just 
a quick installation guide - a more detailed one based on nginx can be found
in the "wiki":http://forge.webpresso.net/projects/rshot/wiki/Installation
(work-in-progress).

### Requirements ###

rshot requires Ruby 1.9 and Rails 3.2 as well as some Rubygems. The installation of
Ruby or an application/web server is not part of this guide.

### Install from GIT ###

Clone the GIT repository in a folder where you want to install the application:

```mkdir /var/www/rshot
git clone http://code.webpresso.net/git/rshot /var/www/rshot```

### Install dependencies ###

The dependencies are managed with Bundler. Install Bundler, if not already installed, with rubygems via 

```gem install bundler```

and install all required rubygems via

```bundle install```

in the installation directory.

### Configuration ###

Edit the following config files:

* config/database.yml (section "production")

  Configure the database you want to use and create a MySQL database if desired.

### Populate the database ###

* `rake db:setup RAILS_ENV=production`
  for initial database setup

* `rake db:migrate RAILS_ENV=production`
  if you're updating an existing installation

### Disable registrations ###

If you don't want to allow everyone to register at your installation,
please have a look at the following link. Sorry that there's not a
convenient way to disable registrations at the moment.

http://stackoverflow.com/questions/5370164/disabling-devise-registration-for-production-environment-only/5370688#5370688

### Start the application ###

To run the application on your local system, you can start it by running

<pre>
rails server
</pre>

in the installation directory.

Versioning
----------

rshot will use the Semantic Versioning guidelines.

Releases will be numbered with the follow format:

`<major>.<minor>.<patch>`

And constructed with the following guidelines:

* Breaking backwards compatibility bumps the major
* New additions without breaking backwards compatibility bumps the minor
* Bug fixes and misc changes bump the patch

For more information on SemVer, please visit http://semver.org/.


Bug tracker
-----------

Bugs are tracked in the project Redmine installation:
https://forge.webpresso.net/projects/rshot/issues


Source code
-----------

The source code of rshot can be found in a Git repository. Browse it
online (https://forge.webpresso.net/projects/rshot/repository) or

`git clone https://code.webpresso.net/git/rshot`


Authors
-------

**Raphael Kallensee**

+ http://raphael.kallensee.name
+ http://identi.ca/rkallensee
+ http://twitter.com/rkallensee


License
---------------------

Copyright 2011-2012 Raphael Kallensee.

[![AGPLv3](http://www.gnu.org/graphics/agplv3-155x51.png)](http://www.gnu.org/licenses/agpl-3.0.html)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
