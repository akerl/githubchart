Gem::Specification.new do |s|
  s.name        = 'githubchart'
  s.version     = '0.0.5'
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

  s.add_runtime_dependency 'githubstats', '~> 0.2.7'
  s.add_runtime_dependency 'rasem', '~> 0.6.1'

  s.add_development_dependency 'rubocop', '~> 0.19.0'
  s.add_development_dependency 'travis-lint', '~> 1.8.0'
  s.add_development_dependency 'rake', '~> 10.1.1'
  s.add_development_dependency 'coveralls', '~> 0.7.0'
  s.add_development_dependency 'rspec', '~> 2.14.1'
  s.add_development_dependency 'fuubar', '~> 1.3.2'
end

