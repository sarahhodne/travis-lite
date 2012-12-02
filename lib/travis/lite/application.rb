require 'bundler'
Bundler.require

require 'net/https'
require 'open-uri'

require 'travis/lite/models/build'
require 'travis/lite/models/repository'

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
        repositories_json = JSON.parse(open('https://api.travis-ci.org/repos/').read)
        @repositories = repositories_json.map { |repository| Repository.new(repository) }

        mustache :index
      end

      get '/:user/:repo' do |user, repo|
        slug = "#{user}/#{repo}"
        repository_json = JSON.parse(open("https://api.travis-ci.org/repos/#{slug}").read)
        @repository = Repository.new(repository_json)

        # @slug = repository.slug
        # @build_number = repository.last_build_number
        # if repository.last_build_finished?
        #   @build_status = repository.last_build_passed? ? 'Passed' : 'Failed'
        # else
        #   @build_status = 'Running'
        # end

        builds_json = JSON.parse(open("https://api.travis-ci.org/repos/#{slug}/builds").read)

        @builds = builds_json.map { |build_json| Build.new(build_json) }

        # @builds = JSON.pretty_generate(JSON.parse(open("https://api.travis-ci.org/repos/#{slug}/builds").read))

        mustache :repository
      end

      error do
        @error = env['sinatra.error']
        erb :error
      end
    end
  end
end
