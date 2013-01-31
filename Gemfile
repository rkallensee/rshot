source 'http://rubygems.org'

gem 'rails', '~> 3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Rails - misc
gem 'json'
gem 'jquery-rails', '~> 2.2.0'

# Assets and asset pipeline
group :assets do
  gem 'sass-rails',   '~> 3.2.6'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier',     '>= 1.3.0'
  gem 'therubyracer', '~> 0.11.3'
end

# custom asset libraries
gem 'select2-rails', '~> 3.2.1'
gem 'fancybox-rails', :git => 'https://github.com/rkallensee/fancybox-rails.git'

# application-specific gems
gem 'devise', '~> 2.2.3'
gem 'devise-encryptable', '~> 0.1.1'
gem 'cancan', '~> 1.6.8'
gem 'paperclip', '~> 3.4.0'
gem 'exifr', '~> 1.1.3'
gem 'kaminari', '~> 0.14.1'
gem 'acts-as-taggable-on', '~> 2.3.3'
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
  gem 'better_errors'
  gem 'binding_of_caller'
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
