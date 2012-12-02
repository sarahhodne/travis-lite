require 'travis/lite/views/layout'

module Travis
  module Lite
    module Views
      class Index < Layout
        def repositories
          @repositories.map do |repository|
            if repository.last_build_finished?
              last_build_status = repository.last_build_passed? ? 'Passed' : 'Failed'
            else
              last_build_status = 'Running'
            end

            {
              slug: repository.slug,
              last_build_number: repository.last_build_number,
              last_build_status: last_build_status,
            }
          end
        end
      end
    end
  end
end
