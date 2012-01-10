rshot
=====

rshot is a social digital photo gallery software written in Ruby. It should make
it easy to publish your digital photos and make them easily browseable by anyone.


Installation
------------

For production you should set up and configure a Passenger/Apache, Thin/Nginx, Mongrel
or similar setup - you can find more about these setups in the interwebs.

### Install from GIT ###

Clone the GIT repository in a folder where you want to install the application:

```mkdir /var/www/rshot
git clone http://code.webpresso.net/git/rshot /var/www/rshot```

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


Versioning
----------

rshot will use the Semantic Versioning guidelines as much as possible.

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