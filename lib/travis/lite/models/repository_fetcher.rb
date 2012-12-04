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

        def self.fetch_with_owner_name(owner_name)
          new(Travis::Lite::API.new).fetch_with_owner_name(owner_name)
        end

        def initialize(api)
          @api = api
        end

        def fetch_recent
          convert_to_repositories(@api.fetch_recent)
        end

        def fetch_with_slug(slug)
          convert_to_repository(@api.fetch_with_slug(slug))
        end

        def fetch_with_owner_name(owner_name)
          convert_to_repositories(@api.fetch_with_owner_name(owner_name))
        end

        private

        def convert_to_repositories(repositories)
          repositories.map { |repository| convert_to_repository(repository) }
        end

        def convert_to_repository(repository)
          Repository.new(repository)
        end
      end
    end
  end
end
