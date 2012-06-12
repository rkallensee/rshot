source 'http://rubygems.org'

gem 'rails', '~> 3.2.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Rails - misc
gem 'json'
gem 'jquery-rails'

# Assets and asset pipeline
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
  gem 'therubyracer', :require => 'v8'
end

# custom asset libraries
gem 'select2-rails', '~> 0.0.4'
gem 'fancybox-rails', '~> 0.1.4'

# application-specific gems
gem 'devise', '~> 2.1.0'
gem 'devise-encryptable', '~> 0.1.1'
gem 'cancan', '~> 1.6.7'
gem 'paperclip', '~> 3.0.4'
gem 'exifr', '~> 1.1.3'
gem 'kaminari', '~> 0.13.0'
gem 'acts-as-taggable-on', '~> 2.3.1'
gem 'acts_as_commentable', '~> 3.0.1'

group :test do
  gem 'rake'
  gem 'sqlite3'
  gem 'test-unit', :require => "test/unit" # this fixes a bug causing trouble in TravisCI: https://github.com/thoughtbot/shoulda-context/pull/4
  gem 'shoulda'
end

group :development do
  gem 'mysql2'
  gem 'thin'
end

group :production do
  gem 'mysql2'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
