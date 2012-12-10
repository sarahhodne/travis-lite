require 'travis/lite/application'
require 'rack/test'

describe Travis::Lite::Application, 'GET /', integration: true do
  include Rack::Test::Methods

  def app
    Travis::Lite::Application
  end

  it 'succeeds' do
    get '/'
    expect(last_response.status).to eq(200)
  end
end
