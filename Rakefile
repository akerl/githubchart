require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

desc 'Update bundle'
task :bundle do
  `bundle update`
end

desc 'Run tests'
RSpec::Core::RakeTask.new(:spec)

desc 'Run Rubocop on the gem'
Rubocop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb', 'spec/**/*.rb', 'bin/**/*']
  task.fail_on_error = true
end

desc 'Run travis-lint on .travis.yml'
task :travislint do
  fail 'There is an issue with your .travis.yml' unless system('travis-lint')
end

task default: [:spec, :travislint, :rubocop, :build, :install]
task release: [:bundle]
