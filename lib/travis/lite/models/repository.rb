module Travis
  module Lite
    module Models
      class Repository
        def initialize(data)
          @data = data
        end

        def slug
          @data['slug']
        end

        def description
          @data['description']
        end

        def last_build_id
          @data['last_build_id']
        end

        def last_build_number
          @data['last_build_number']
        end

        def last_build_finished?
          !!@data['last_build_finished_at']
        end

        def last_build_passed?
          @data['last_build_result'] == 0
        end

        def last_build_duration
          @data['last_build_duration']
        end

        def last_build_started_at
          @data['last_build_started_at']
        end

        def last_build_finished_at
          @data['last_build_finished_at']
        end
      end
    end
  end
end
