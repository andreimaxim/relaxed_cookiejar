
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'relaxed_cookiejar/version'

Gem::Specification.new do |spec|
  spec.name          = 'relaxed_cookiejar'
  spec.version       = RelaxedCookieJar::VERSION
  spec.authors       = ['Andrei Maxim']
  spec.email         = ['andrei@andreimaxim.ro']

  spec.summary       = %q{Relaxed options for CookieJar}
  spec.homepage      = 'https://github.com/andreimaxim/relaxed_cookiejar'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'simplecov', '~> 0.15'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  # Add the original cookiejar gem as a fixed dependency so
  # people doing any kind of updates in the future will have
  # a Bundler error instead of trying to figure out which gem
  # is monkeypatched.
  spec.add_dependency 'cookiejar', '>= 0.3.3'
end
