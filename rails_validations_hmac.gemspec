lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.platform  = Gem::Platform::RUBY
  s.name      = 'rails_validations_hmac'
  s.version   = '0.0.3'
  s.summary   = 'HMAC validation based on secret and content'
  s.description = 'HMAC Validation for Rails.'

  s.required_ruby_version = '>= 1.9.2'
  s.require_paths = ['lib']
  s.files = Dir['README.md', 'Gemfile', 'Rakefile', 'lib/**/*']
  s.test_files = Dir['spec/**/*']

  s.author    = "Margus Pärt"
  s.email     = 'margus@tione.eu'
  s.homepage  = 'https://github.com/tione/rails_validations_hmac'

  s.add_development_dependency 'rails'
  s.add_development_dependency 'activemodel'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'mongoid'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-spork'
end
