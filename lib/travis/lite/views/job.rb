require 'json'
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
            branch: job.commit.branch,
            config_label: job_label(job.config),
            config: JSON.pretty_generate(job.config),
            compare_url: job.commit.compare_url,
            message: job.commit.message,
            log: job_log
          }
        end

        def job_log
          job.log ? job.log.clean_body : ""
        end

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
