module Travis
  module Lite
    module Models
      class Config
        def initialize(data)
          @data = data
        end

        def language
          @data['language']
        end

        def label
          keys = %w[rvm compiler env]
          keys << language

          sub = keys.map { |key| @data[key] }.compact.join(" ")

          "#{language} #{sub}"
        end

        def inspect
          @data.inspect
        end
      end
    end
  end
end
