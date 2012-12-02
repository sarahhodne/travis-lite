require 'spec_helper'

require 'travis/lite/models/repository_fetcher'

describe Travis::Lite::Models::RepositoryFetcher, '#fetch_recent' do
  subject { object.fetch_recent }
  let(:object) { described_class.new(api) }
  let(:api) { double('api', fetch_recent: [repository] * 10) }
  let(:repository) { double('repository') }

  it 'should call the api' do
    api.should_receive(:fetch_recent)
    subject
  end

  it { should have(10).items }
end
