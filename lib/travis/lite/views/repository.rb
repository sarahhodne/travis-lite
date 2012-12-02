require 'travis/lite/views/layout'

module Travis
  module Lite
    module Views
      class Repository < Layout
        def slug
          @repository.slug
        end

        def builds
          @builds.map { |build| convert_build(build) }
        end

        private

        def convert_build(build)
          if build.finished?
            build_status = build.passed? ? 'Passed' : 'Failed'
          else
            build_status = 'Running'
          end
          {
            number: build.number,
            status: build_status,
          }
        end
      end
    end
  end
end
