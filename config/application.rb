require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

class TravisClearCacheMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env).tap do |result|
      Travis.session.clear_cache
    end
  end
end

module TravisLite
  class Application < Rails::Application
    config.assets.precompile += %w[*.png *.jpg *.jpeg *.gif]

    config.middleware.use TravisClearCacheMiddleware
  end
end
