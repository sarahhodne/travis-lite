require 'bundler'
Bundler.require

module Travis
  module Lite
    class Application < Sinatra::Base
      configure :production do
        disable :raise_exceptions
        disable :show_exceptions

        set :sass, style: :compressed
      end

      get '/style.css' do
        sass :style
      end

      get '/' do
        erb :index
      end

      error do
        @error = env['sinatra.error']
        erb :error
      end
    end
  end
end
