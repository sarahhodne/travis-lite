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
      end
    end
  end
end
