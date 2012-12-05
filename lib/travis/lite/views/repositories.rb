require 'travis/lite/views/layout'

module Travis
  module Lite
    module Views
      class Repositories < Layout
        def repositories
          @repositories.map do |repository|
            {
              slug: repository.slug,
              last_build_id: repository.last_build_id,
              last_build_number: repository.last_build_number,
              last_build_status: format_build_status(build_status(repository)),
              row_class: class_for_build_status(build_status(repository)),
            }
          end
        end

        private

        def build_status(repository)
          if repository.last_build_finished?
            repository.last_build_passed? ? :passed : :failed
          else
            :running
          end
        end

        def format_build_status(status)
          case status
          when :passed
            '<span class="text-success">Passed</span>'
          when :failed
            '<span class="text-error">Failed</span>'
          when :running
            'Running'
          end
        end

        def class_for_build_status(status)
          case status
          when :passed
            :success
          when :failed
            :error
          end
        end
      end
    end
  end
end
