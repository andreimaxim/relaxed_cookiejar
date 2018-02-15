if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails'
  puts 'required simplecov'
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'rspec/collection_matchers'
require 'relaxed_cookiejar'