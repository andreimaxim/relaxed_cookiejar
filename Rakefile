require "bundler/gem_tasks"
require "rake/testtask"


begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new do |t|
    t.ruby_opts = %w(-w)
    t.pattern = 'spec/**/*_spec.rb'
  end
  task test: :spec
rescue LoadError
  puts 'Warning: unable to load rspec tasks'
end

task :default => :test
