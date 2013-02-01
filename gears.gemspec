Gem::Specification.new do |s|
  s.name        = 'gears'
  s.version     = '0.0.0'
  s.date        = '2013-01-31'
  s.summary     = ''
  s.description = s.summary
  s.authors     = ['James Dabbs']
  s.email       = 'jamesdabbs@gmail.com'
  s.files       = %w{ Gemfile Rakefile gears.gemspec }
  s.files      += Dir['lib/**/*.rb']
  s.homepage    = 'http://github.com/jamesdabbs/gears'

  s.add_dependency 'activemodel'
  s.add_dependency 'virtus'
end