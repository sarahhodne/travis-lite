require 'travis/lite/views/layout'

module Travis
  module Lite
    module Views
      class Job < Layout
        def slug
          @repository.slug
        end

        def job_number
          @job.number
        end

        def build_number
          job_number.split('.').first
        end

        def job
          convert_job(@job)
        end

        private

        def convert_job(job)
          {
            build_id: job.build_id,
            status: format_build_status(job_status(job)),
            status_class: class_for_build_status(job_status(job)),
            branch: job.branch,
            config_label: job.config.label,
            config: job.config.inspect,
            compare_url: job.compare_url,
            message: job.message,
            log: job.log
          }
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
