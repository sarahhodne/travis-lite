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
          @build.jobs.map { |job| convert_job(job) }
        end

        private

        def convert_job(job)
          {
            id: job.id,
            number: job.number,
            status: format_build_status(job_status(job)),
            config_label: job_label(job.config),
            allow_failure: job.allow_failure?,
            row_class: class_for_build_status(job_status(job))
          }
        end

        private

        def job_label(config)
          keys = %w[rvm compiler env]
          keys << config['language']

          sub = config.values_at(keys).compact.join(" ")

          "#{config['language']} #{sub}"
        end

        def job_status(job)
          if job.finished?
            job.passed? ? :passed : :failed
          else
            :running
          end
        end
      end
    end
  end
end
