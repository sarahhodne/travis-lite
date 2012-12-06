require 'spec_helper'

require 'travis/lite/models/build_fetcher'

describe Travis::Lite::Models::BuildFetcher, '#fetch_recent_for_slug' do
  subject { object.fetch_recent_for_slug(slug) }
  let(:object) { described_class.new(api) }
  let(:api) { double('api', fetch_recent_for_slug: [build] * 10) }
  let(:build) { double('build') }

  let(:slug) { 'travis-ci/travis-ci' }

  it 'should call the api' do
    api.should_receive(:fetch_recent_for_slug).with(slug)
    subject
  end

  it { should have(10).items }

  it 'should convert the result to Build objects' do
    expect(subject.first).to be_a(Travis::Lite::Models::Build)
  end
end
