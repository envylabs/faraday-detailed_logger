# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faraday/detailed_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "faraday-detailed_logger"
  spec.version       = Faraday::DetailedLogger::VERSION
  spec.authors       = ["Envy Labs"]
  spec.email         = [""]
  spec.summary       = %q{A detailed request and response logger for Faraday.}
  spec.description   = %q{A Faraday middleware for logging request and response activity including method, URI, headers, and body at varying log levels.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"

  spec.add_development_dependency "appraisal", "~> 1.0"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
end
