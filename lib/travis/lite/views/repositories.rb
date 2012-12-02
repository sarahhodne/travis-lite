require 'travis/lite/views/layout'

module Travis
  module Lite
    module Views
      class Repositories < Layout
        def repositories
          @repositories.map do |repository|
            {
              slug: repository.slug,
              last_build_number: repository.last_build_number,
              last_build_status: build_status(repository),
            }
          end
        end

        private

        def build_status(repository)
          if repository.last_build_finished?
            repository.last_build_passed? ? 'Passed' : 'Failed'
          else
            'Running'
          end
        end
      end
    end
  end
end
