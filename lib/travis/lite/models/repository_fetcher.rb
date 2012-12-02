require 'travis/lite/api'
require 'travis/lite/models/repository'

module Travis
  module Lite
    module Models
      class RepositoryFetcher
        def self.fetch_recent
          new(Travis::Lite::API.new).fetch_recent
        end

        def self.fetch_with_slug(slug)
          new(Travis::Lite::API.new).fetch_with_slug(slug)
        end

        def initialize(api)
          @api = api
        end

        def fetch_recent
          @api.fetch_recent.map { |repository| Repository.new(repository) }
        end

        def fetch_with_slug(slug)
          Repository.new(@api.fetch_with_slug(slug))
        end
      end
    end
  end
end
