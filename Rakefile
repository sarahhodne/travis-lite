require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec:unit') do |task|
  task.rspec_opts = '--tag ~integration'
end

RSpec::Core::RakeTask.new('spec:integration') do |task|
  task.rspec_opts = '--tag integration'
end

task spec: ['spec:unit', 'spec:integration']

task default: :spec
task test: :spec
