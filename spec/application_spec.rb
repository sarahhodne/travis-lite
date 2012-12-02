require 'spec_helper'

ENV['RACK_ENV'] = 'test'
require File.expand_path('../../lib/travis/lite/application', __FILE__)

describe Travis::Lite::Application do
  include Rack::Test::Methods

  describe 'GET /' do
    before do
      get '/'
    end

    it 'works' do
      last_response.should be_ok
    end
  end

  def app
    Travis::Lite::Application
  end
end
