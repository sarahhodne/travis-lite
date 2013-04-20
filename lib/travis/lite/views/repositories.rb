require 'travis/lite/views/layout'

module Travis
  module Lite
    module Views
      class Repositories < Layout
        def repositories
          @repositories.map do |repository|
            {
              slug: repository.slug,
              last_build_id: repository.last_build.id,
              last_build_number: repository.last_build.number,
              last_build_status: format_build_status(build_status(repository)),
              row_class: class_for_build_status(build_status(repository)),
            }
          end
        end

        private

        def build_status(repository)
          if repository.last_build.finished?
            repository.last_build.passed? ? :passed : :failed
          else
            :running
          end
        end
      end
    end
  end
end
