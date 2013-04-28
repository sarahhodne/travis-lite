require 'bundler'
Bundler.require

require 'travis/lite/views/repositories'
require 'travis/lite/views/repository'
require 'travis/lite/views/build'
require 'travis/lite/views/job'

require 'travis'

module Travis
  module Lite
    class Application < Sinatra::Base
      register Mustache::Sinatra

      set :mustache, {
        views: File.expand_path('../views/', __FILE__),
        templates: 'templates/',
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
        @repositories = Travis::Repository.current
        @title = 'Latest Builds'
        mustache :repositories
      end

      get '/:user/?' do |user|
        @repositories = Travis::Repository.find_all(owner_name: user)
        @title = "#{user}'s repositories"
        mustache :repositories
      end

      get '/:user/:repo/?' do |user, repo|
        slug = "#{user}/#{repo}"
        @title = slug
        begin
          @repository = Travis::Repository.find(slug)
          @builds = @repository.recent_builds
          mustache :repository
        rescue Travis::Client::NotFound
          not_found
        end
      end

      get '/:user/:repo/builds/:build/?' do |user, repo, build|
        slug = "#{user}/#{repo}"
        @title = slug
        begin
          @repository = Travis::Repository.find(slug)
          @build = @repository.builds(id: build).first
        rescue Travis::Client::NotFound
          not_found
        end
        if @build.jobs.size == 1
          redirect "#{slug}/jobs/#{@build.jobs.first.id}"
        else
          mustache :build
        end
      end

      get '/:user/:repo/jobs/:job/?' do |user, repo, job|
        slug = "#{user}/#{repo}"
        @title = slug
        begin
          @repository = Travis::Repository.find(slug)
          @job = Travis::Job.find(job)
        rescue Travis::Client::NotFound
          not_found
        end
        mustache :job
      end

      error do
        @error = env['sinatra.error']
        erb :error
      end

      not_found { erb :not_found }
    end
  end
end
