require 'spec_helper'

require 'travis/lite/models/build_fetcher'

describe Travis::Lite::Models::BuildFetcher, '#fetch_build_for_slug' do
  subject { object.fetch_build_for_slug(slug, build) }

  let(:object) { described_class.new(api) }
  let(:api) { double('api', fetch_build_for_slug: build) }
  let(:build) { double('build') }
  let(:slug) { 'travis-ci/travis-ci' }

  it 'should call the api' do
    api.should_receive(:fetch_build_for_slug).with(slug, build)
    subject
  end

  it 'should convert the result to Build object' do
    subject.should be_a(Travis::Lite::Models::Build)
  end
end
