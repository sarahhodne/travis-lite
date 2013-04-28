source 'https://rubygems.org'

gem 'rake', '~> 10.0'

gem 'unicorn'

gem 'sinatra', '~> 1.3'
gem 'mustache', '~> 0.99', require: 'mustache/sinatra'

gem 'json', '~> 1.7'
gem 'sass', '~> 3.2'

gem 'travis', '~> 1.2.0'

gem 'newrelic_rpm'
gem 'sentry-raven', github: 'getsentry/raven-ruby'

group :test do
  gem 'rspec', '~> 2.12'
  gem 'rack-test', '~> 0.6', require: 'rack/test'
  gem 'vcr'
  gem 'webmock'
  gem 'coveralls'
end

group :development do
  gem 'foreman'
  gem 'rerun'
  gem 'pry'
end
