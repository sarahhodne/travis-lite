require 'travis/lite/application'
require 'rack/test'

describe Travis::Lite::Application, 'GET /:user/:repo/jobs/:build_id', integration: true do
  include Rack::Test::Methods

  def app
    Travis::Lite::Application
  end

  it 'succeeds' do
    get '/henrikhodne/travis-lite/jobs/3587731'
    expect(last_response.status).to eq(200)
  end
end
