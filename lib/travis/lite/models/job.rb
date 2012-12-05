require 'travis/lite/models/config'

module Travis
  module Lite
    module Models
      class Job
        def initialize(data)
          @data = data
        end

        def id
          @data['id']
        end

        def number
          @data['number']
        end

        def build_id
          @data['build_id']
        end

        def finished?
          @data['state'] == 'finished'
        end

        def passed?
          @data['result'] == 0
        end

        def branch
          @data['branch']
        end

        def compare_url
          @data['compare_url']
        end

        def message
          @data['message']
        end

        def config
          Config.new(@data['config'])
        end

        def log
          @data['log']
        end
      end
    end
  end
end
