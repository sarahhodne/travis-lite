require 'travis/lite/api'
require 'travis/lite/models/job'

module Travis
  module Lite
    module Models
      class JobFetcher
        def self.fetch_job(job)
          new(Travis::Lite::API.new).fetch_job(job)
        end

        def initialize(api)
          @api = api
        end

        def fetch_job(job)
          Job.new(@api.fetch_job(job))
        end
      end
    end
  end
end
