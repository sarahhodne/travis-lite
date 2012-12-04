source :rubygems

ruby '1.9.3' rescue nil

gem 'rake', '~> 10.0'

gem 'unicorn'

gem 'sinatra', '~> 1.3'
gem 'mustache', '~> 0.99', require: 'mustache/sinatra'

gem 'json', '~> 1.7'
gem 'sass', '~> 3.2'

gem 'faraday', '~> 0.8.4'
gem 'faraday_middleware', '~> 0.9.0'

gem 'newrelic_rpm'

group :test do
  gem 'rspec', '~> 2.12'
  gem 'rack-test', '~> 0.6', require: 'rack/test'
end

group :development do
  gem 'foreman'
  gem 'rerun'
end
