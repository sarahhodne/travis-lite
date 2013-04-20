require 'spec_helper'
require 'travis/lite/application'
require 'rack/test'

describe Travis::Lite::Application, 'GET /:user', :integration, :vcr do
  include Rack::Test::Methods

  def app
    Travis::Lite::Application
  end

  it 'succeeds' do
    get '/henrikhodne'
    expect(last_response.status).to eq(200)
  end
end
