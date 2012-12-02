require 'faraday'
require 'faraday_middleware'

module Travis
  module Lite
    class API
      def initialize
        @conn = Faraday.new(url: 'https://api.travis-ci.org') do |conn|
          conn.request :json

          conn.response :json, content_type: /\bjson$/

          conn.adapter Faraday.default_adapter
        end
      end

      def fetch_recent
        @conn.get('/repos').body
      end

      def fetch_with_slug(slug)
        @conn.get("/repos/#{slug}").body
      end
    end
  end
end
