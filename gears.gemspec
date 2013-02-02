Gem::Specification.new do |s|
  s.name        = 'gears'
  s.version     = '0.0.1'
  s.date        = '2013-01-31'
  s.summary     = 'A simple Ruby form library, intended for use with Rails'
  s.description = 'Gears Forms encapsulate validation logic into an object with that single responsibility'
  s.authors     = ['James Dabbs']
  s.email       = 'jamesdabbs@gmail.com'
  s.files       = %w{ Gemfile Rakefile README.md gears.gemspec }
  s.files      += Dir['lib/**/*.rb']
  s.test_files  = Dir['spec/**/*.rb']
  s.homepage    = 'http://github.com/jamesdabbs/gears'

  s.add_dependency 'activemodel'
  s.add_dependency 'virtus'
end