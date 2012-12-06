require 'bundler'
Bundler.require(:default, :test)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
