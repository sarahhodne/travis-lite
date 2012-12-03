module Travis
  module Lite
    module Views
      class Layout < Mustache
        def title
          @title || 'Travis Lite'
        end

        def full_page_url
          "http://travis-ci.org#{@request_path}"
        end
      end
    end
  end
end
