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
          {
            id: build.id,
            number: build.number,
            status: format_build_status(build_status(build)),
            message: build.message,
            branch: build.branch,
            row_class: class_for_build_status(build_status(build)),
          }
        end

        private

        def build_status(build)
          if build.finished?
            build.passed? ? :passed : :failed
          else
            :running
          end
        end
      end
    end
  end
end
