source 'https://rubygems.org'

#Specified ruby version required for heroku
ruby "2.2.4"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'


# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
gem 'turbolinks', '~> 2.5.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#Clearence gem for auth


group :development do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
	gem 'byebug'
end

group :development do

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end


group :production do
    #Postgres SQL gem
    gem 'pg'

    #thin gem for heroku HTTPS server
    gem 'thin'

    #Gem to enable features such as static asset serving and logging on Heroku
    gem 'rails_12factor'

	gem "therubyracer"
end

#Paperclip for uploading pictures
gem 'paperclip'

#not working...
gem 'pry-rails'
gem 'better_errors'
gem 'awesome_print'
gem 'minitest-rails'
gem 'hirb'
gem 'faker'

gem 'bootstrap'
gem "less-rails"
gem 'sass-rails'
gem 'autoprefixer-rails'
gem 'font-awesome-rails'
gem 'clearance', '~> 1.5'
gem 'gon'
gem 'popular'
gem 'deep_copy'
gem 'responders', '~> 2.0'
