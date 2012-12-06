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
            status: format_build_status(matrix_status(matrix)),
            config_label: matrix.config.label,
            allow_failure: matrix.allow_failure?,
            row_class: class_for_build_status(matrix_status(matrix))
          }
        end

        private

        def matrix_status(matrix)
          if matrix.finished?
            matrix.passed? ? :passed : :failed
          else
            :running
          end
        end
      end
    end
  end
end
