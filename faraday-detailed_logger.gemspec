# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faraday/detailed_logger/version'

Gem::Specification.new do |spec|
  spec.name = 'faraday-detailed_logger'
  spec.version = Faraday::DetailedLogger::VERSION
  spec.authors = ['Envy Labs']
  spec.email = ['']

  spec.summary = 'A detailed request and response logger for Faraday.'
  spec.description = %(
    A Faraday middleware for logging request and response activity including
    method, URI, headers, and body at varying log levels.
  )
  spec.homepage = 'https://github.com/envylabs/faraday-detailed_logger'
  spec.license = 'MIT'

  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.metadata['changelog_uri'] = 'https://github.com/envylabs/faraday-detailed_logger/blob/master/CHANGELOG.md'
  spec.metadata['source_code_uri'] = 'https://github.com/envylabs/faraday-detailed_logger'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/envylabs/faraday-detailed_logger/issues'

  spec.add_runtime_dependency 'faraday', '>= 0.8', '< 2'

  spec.add_development_dependency 'appraisal', '~> 2.0'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'coveralls', '~> 0.8.0'
  spec.add_development_dependency 'license_finder', '~> 6.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop-rails_config', '~> 1.3.0'
end
