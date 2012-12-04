require 'faraday'
require 'faraday_middleware'

module Travis
  module Lite
    class API
      class NotFoundError < StandardError
      end

      def initialize
        @conn = Faraday.new(url: 'https://api.travis-ci.org') do |conn|
          conn.request :json

          conn.response :json, content_type: /\bjson$/

          conn.adapter Faraday.default_adapter
        end
      end

      def fetch_recent
        handle_response @conn.get('/repos')
      end

      def fetch_with_slug(slug)
        handle_response @conn.get("/repos/#{slug}")
      end

      def fetch_recent_for_slug(slug)
        handle_response @conn.get("/repos/#{slug}/builds")
      end

      def fetch_with_owner_name(owner_name)
        handle_response @conn.get('/repos', owner_name: owner_name)
      end

      private

      def handle_response(response)
        if response.status == 404
          raise NotFoundError
        end

        response.body
      end
    end
  end
end
