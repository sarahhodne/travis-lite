require 'spec_helper'

require 'travis/lite/models/job_fetcher'

describe Travis::Lite::Models::JobFetcher, '#fetch_job' do
  subject { object.fetch_job(job) }

  let(:object) { described_class.new(api) }
  let(:api) { double('api', fetch_job: job) }
  let(:job) { double('job') }

  it 'should call the api' do
    api.should_receive(:fetch_job).with(job)
    subject
  end

  it 'should convert the result to Job object' do
    expect(subject).to be_a(Travis::Lite::Models::Job)
  end
end
