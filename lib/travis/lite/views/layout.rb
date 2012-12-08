module Travis
  module Lite
    module Views
      class Layout < Mustache
        def title
          @title
        end

        def full_page_url
          "http://travis-ci.org#{@request_path}"
        end

        def format_build_status(status)
          status.to_s.capitalize
        end

        def class_for_build_status(status)
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
