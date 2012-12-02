require 'spec_helper'

require 'travis/lite/models/repository_fetcher'

describe Travis::Lite::Models::RepositoryFetcher, '#fetch_with_slug' do
  subject { object.fetch_with_slug(slug) }
  let(:object) { described_class.new(api) }
  let(:api) { double('api', fetch_with_slug: repository) }
  let(:repository) { double('repository') }

  let(:slug) { 'travis-ci/travis-ci' }

  it 'should call the api' do
    api.should_receive(:fetch_with_slug).with(slug)
    subject
  end

  it { should be_a(Travis::Lite::Models::Repository) }
end
