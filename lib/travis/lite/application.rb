require 'bundler'
Bundler.require

require 'heroku-api'
require 'gh'

require 'travis/lite/models/repository_fetcher'
require 'travis/lite/models/build_fetcher'

require 'travis/lite/views/repositories'
require 'travis/lite/views/repository'

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

        require 'newrelic_rpm'
      end

      set :public_folder, File.expand_path('../../../../assets', __FILE__)

      before do
        @request_path = env['REQUEST_PATH']
      end

      get '/style.css' do
        scss :style
      end

      get '/' do
        @repositories = RepositoryFetcher.fetch_recent
        @title = 'Latest Builds'
        mustache :repositories
      end

      get '/deployed-sha', provides: :txt do
        short_sha = Heroku::API.new.get_releases('travis-lite').body.last['commit']
        long_sha = GH["repos/henrikhodne/travis-lite/commits/#{short_sha}"]['sha']
      end

      get '/:user/?' do |user|
        @repositories = RepositoryFetcher.fetch_with_owner_name(user)
        @title = "#{user}'s repositories"
        mustache :repositories
      end

      get '/:user/:repo' do |user, repo|
        slug = "#{user}/#{repo}"
        @title = slug
        @repository = RepositoryFetcher.fetch_with_slug(slug)
        @builds = BuildFetcher.fetch_recent_for_slug(slug)
        mustache :repository
      end

      error do
        @error = env['sinatra.error']
        erb :error
      end

      error(API::NotFoundError) { not_found }

      not_found { erb :not_found }
    end
  end
end
