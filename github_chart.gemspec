Gem::Specification.new do |s|
    s.name        = 'github_chart'
    s.version     = '0.1.0'
    s.date        = Time.now.strftime("%Y-%m-%d")

    s.summary     = 'Generate an SVG of Github contributions data'
    s.description = "Uses github_stats to grab Github contributions scores and converts that into an SVG"
    s.authors     = ['Les Aker']
    s.email       = 'me@lesaker.org'
    s.homepage    = 'https://github.com/akerl/github_chart'
    s.license     = 'MIT'

    s.files       = `git ls-files`.split
    s.executables = ['github_chart']

    s.add_runtime_dependency 'github_stats'
    s.add_runtime_dependency 'rasem'
end

