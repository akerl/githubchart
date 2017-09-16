$:.unshift File.expand_path('../lib/', __FILE__)
require 'githubchart/version'

Gem::Specification.new do |s|
  s.name        = 'githubchart'
  s.version     = GithubChart::VERSION
  s.date        = Time.now.strftime("%Y-%m-%d")
  s.summary     = 'Generate an SVG of Github contributions data'
  s.description = "Uses GithubStats to grab Github contributions scores and converts that into an SVG"
  s.authors     = ['Les Aker']
  s.email       = 'me@lesaker.org'
  s.homepage    = 'https://github.com/akerl/githubchart'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split
  s.test_files  = `git ls-files spec/*`.split
  s.executables = ['githubchart']

  s.add_runtime_dependency 'githubstats', '~> 1.4.0'
  s.add_runtime_dependency 'svgplot', '~> 1.0.0'

  s.add_development_dependency 'rubocop', '~> 0.50.0'
  s.add_development_dependency 'goodcop', '~> 0.1.0'
  s.add_development_dependency 'rake', '~> 12.1.0'
  s.add_development_dependency 'codecov', '~> 0.1.1'
  s.add_development_dependency 'rspec', '~> 3.6.0'
  s.add_development_dependency 'fuubar', '~> 2.2.0'
end

