module Travis
  module Lite
    module Models
      class Build
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
          @data['state'] == 'finished'
        end

        def passed?
          @data['result'] == 0
        end

        def duration
          @data['duration']
        end

        def started_at
          @data['started_at']
        end

        def finished_at
          @data['finished_at']
        end
      end
    end
  end
end
