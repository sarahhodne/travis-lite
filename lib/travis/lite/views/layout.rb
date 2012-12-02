module Travis
  module Lite
    module Views
      class Layout < Mustache
        def title
          @title || 'Travis Lite'
        end
      end
    end
  end
end
