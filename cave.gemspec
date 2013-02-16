Gem::Specification.new do |s|
  s.name        = 'cave'
  s.version     = '0.0.1'
  s.date        = '2013-01-31'
  s.summary     = 'A simple Ruby form library, intended for use with Rails'
  s.description = 'Cave Forms encapsulate validation logic into an object with that single responsibility'
  s.authors     = ['James Dabbs']
  s.email       = 'jamesdabbs@gmail.com'
  s.files       = %w{ Gemfile Rakefile README.md cave.gemspec }
  s.files      += Dir['lib/**/*.rb']
  s.test_files  = Dir['spec/**/*.rb']
  s.homepage    = 'http://github.com/jamesdabbs/cave'

  s.add_dependency 'actionpack'
  s.add_dependency 'virtus'
end