require 'travis/lite/api'
require 'travis/lite/models/build'

module Travis
  module Lite
    module Models
      class BuildFetcher
        def self.fetch_recent_for_slug(slug)
          new(Travis::Lite::API.new).fetch_recent_for_slug(slug)
        end

        def self.fetch_build_for_slug(slug, build)
          new(Travis::Lite::API.new).fetch_build_for_slug(slug, build)
        end

        def initialize(api)
          @api = api
        end

        def fetch_recent_for_slug(slug)
          @api.fetch_recent_for_slug(slug).map { |build| Build.new(build) }
        end

        def fetch_build_for_slug(slug, build)
          Build.new(@api.fetch_build_for_slug(slug, build))
        end
      end
    end
  end
end
