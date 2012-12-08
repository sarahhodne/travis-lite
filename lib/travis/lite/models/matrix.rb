require 'travis/lite/models/config'

module Travis
  module Lite
    module Models
      class Matrix
        def initialize(data)
          @data = data
        end

        def id
          @data['id']
        end

        def number
          @data['number']
        end

        def finished?
          @data['finished_at']
        end

        def passed?
          @data['result'] == 0
        end

        def allow_failure?
          @data['allow_failure']
        end

        def config
          Config.new(@data['config'])
        end
      end
    end
  end
end
