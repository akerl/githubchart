require 'English'
$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'githubchart/version'

Gem::Specification.new do |s|
  s.name        = 'githubchart'
  s.version     = GithubChart::VERSION
  s.summary     = 'Generate an SVG of Github contributions data'
  s.description = 'Uses GithubStats to grab Github contributions scores and converts that into an SVG'
  s.authors     = ['Les Aker']
  s.email       = 'me@lesaker.org'
  s.homepage    = 'https://github.com/akerl/githubchart'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split
  s.executables = ['githubchart']

  s.add_runtime_dependency 'githubstats', '~> 3.3.0'
  s.add_runtime_dependency 'matrix', '~> 0.4.2'
  s.add_runtime_dependency 'svgplot', '~> 1.0.0'

  s.add_development_dependency 'goodcop', '~> 0.9.7'
  s.metadata['rubygems_mfa_required'] = 'true'
end
