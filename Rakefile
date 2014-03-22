require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

desc 'Run tests'
RSpec::Core::RakeTask.new(:spec)

desc 'Run Rubocop on the gem'
Rubocop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb', 'spec/**/*.rb', 'bin/**/*']
  task.fail_on_error = true
end

task default: [:spec, :rubocop, :build, :install]
