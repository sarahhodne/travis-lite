require 'bundler'
Bundler.require

require 'net/https'
require 'open-uri'

require 'travis/lite/models/repository'

module Travis
  module Lite
    class Application < Sinatra::Base
      configure :production do
        disable :raise_exceptions
        disable :show_exceptions

        set :sass, style: :compressed
      end

      get '/style.css' do
        scss :style
      end

      get '/' do
        repositories_json = JSON.parse(open('https://api.travis-ci.org/repos/').read)
        @repositories = repositories_json.map { |repository| Models::Repository.new(repository) }

        erb :index
      end

      error do
        @error = env['sinatra.error']
        erb :error
      end
    end
  end
end
