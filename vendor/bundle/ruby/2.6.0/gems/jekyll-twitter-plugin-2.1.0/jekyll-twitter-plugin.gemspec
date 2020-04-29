# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "jekyll-twitter-plugin"
  spec.version       = "2.1.0"
  spec.authors       = ["Rob Murray"]
  spec.email         = ["robmurray17@gmail.com"]
  spec.summary       = "A Liquid tag plugin for Jekyll blogging engine that embeds Tweets, Timelines and more from Twitter API."
  spec.homepage      = "https://github.com/rob-murray/jekyll-twitter-plugin"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.0.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "byebug" if RUBY_VERSION >= "2.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "webmock"
end
