require 'travis/lite/api'
require 'travis/lite/models/build'

module Travis
  module Lite
    module Models
      class BuildFetcher
        def self.fetch_recent_for_slug(slug)
          new(Travis::Lite::API.new).fetch_recent_for_slug(slug)
        end

        def initialize(api)
          @api = api
        end

        def fetch_recent_for_slug(slug)
          @api.fetch_recent_for_slug(slug).map { |build| Build.new(build) }
        end
      end
    end
  end
end
