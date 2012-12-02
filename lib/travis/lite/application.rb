require 'bundler'
Bundler.require

require 'net/https'
require 'open-uri'

require 'travis/lite/models/build'
require 'travis/lite/models/repository'
require 'travis/lite/models/repository_fetcher'

require 'travis/lite/views/index'

require 'mustache/sinatra'

module Travis
  module Lite
    class Application < Sinatra::Base

      register Mustache::Sinatra
      include Models

      set :mustache, {
        views: File.expand_path('../views/', __FILE__),
        templates: File.expand_path('../templates/', __FILE__),
        namespace: Travis::Lite,
      }

      configure :production do
        disable :raise_exceptions
        disable :show_exceptions

        set :sass, style: :compressed
      end

      get '/style.css' do
        scss :style
      end

      get '/' do
        @repositories = RepositoryFetcher.fetch_recent
        mustache :index
      end

      get '/:user/:repo' do |user, repo|
        slug = "#{user}/#{repo}"
        @repository = RepositoryFetcher.fetch_with_slug(slug)

        builds_json = JSON.parse(open("https://api.travis-ci.org/repos/#{slug}/builds").read)
        @builds = builds_json.map { |build_json| Build.new(build_json) }

        mustache :repository
      end

      error do
        @error = env['sinatra.error']
        erb :error
      end
    end
  end
end
