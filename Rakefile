# documentation
namespace 'doc' do
  task :generate do
    puts `rm -rf ./doc`
    puts `yard doc --exclude 'test' --exclude 'Rakefile' --exclude 'Gemfile'`
  end
end

# vc
namespace 'vc' do
  task :commit do
    puts `git add -A`
    puts `git commit -a --message="#{ENV['message']}"`
    puts `git push origin master`
  end
end

# gem
namespace 'gem' do
  task :build do
    puts `gem build rails_validations_hmac.gemspec`
  end
  task :push do
    puts `gem push rails_validations_hmac*.gem`
  end
  task :remove_build do
    puts `rm -rf rails_validations_hmac*.gem`
  end
  task :publish => [:build, :push, :remove_build]
end

# tests
namespace 'tests' do
  task :run do
    spawn "rspec -f doc --color --tty  #{ENV['OPTS']} #{ENV['SPEC']}"
  end
  task :monitor do
    spawn "bundle exec guard start"
  end
end

