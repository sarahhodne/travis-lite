require 'travis/lite/views/layout'

module Travis
  module Lite
    module Views
      class Build < Layout
        def slug
          @repository.slug
        end

        def build_number
          @build.number
        end

        def matrix
          @build.matrix.map { |matrix| convert_matrix(matrix) }
        end

        private

        def convert_matrix(matrix)
          {
            id: matrix.id,
            number: matrix.number,
            status: format_status(status(matrix)),
            config_label: matrix.config.label,
            allow_failure: matrix.allow_failure?,
            row_class: class_for_status(status(matrix), matrix.allow_failure?)
          }
        end

        private

        def status(matrix)
          if matrix.finished?
            matrix.passed? ? :passed : :failed
          else
            :running
          end
        end

        def format_status(status)
          status.to_s.capitalize
        end

        def class_for_status(status, allow_failure)
          case status
          when :passed
            :success
          when :failed
            :error
          when :running
            :warning
          end
        end
      end
    end
  end
end
