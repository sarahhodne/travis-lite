require 'spec_helper'

require 'travis/lite/models/repository_fetcher'

describe Travis::Lite::Models::RepositoryFetcher, '#fetch_with_owner_name' do
  subject { object.fetch_with_owner_name(owner_name) }
  let(:object) { described_class.new(api) }
  let(:api) { double('api', fetch_with_owner_name: [repository] * 10) }
  let(:repository) { double('repository') }

  let(:owner_name) { 'travis-ci' }

  it 'should call the api' do
    api.should_receive(:fetch_with_owner_name).with(owner_name)
    subject
  end

  it { should have(10).items }

  it 'should convert the result to Repository objects' do
    expect(subject.first).to be_a(Travis::Lite::Models::Repository)
  end
end
