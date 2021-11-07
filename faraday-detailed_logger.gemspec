# frozen_string_literal: true

require_relative 'lib/faraday/detailed_logger/version'

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
  spec.required_ruby_version = '>= 2.4.0'

  spec.metadata['bug_tracker_uri'] = 'https://github.com/envylabs/faraday-detailed_logger/issues'
  spec.metadata['changelog_uri'] = 'https://github.com/envylabs/faraday-detailed_logger/blob/main/CHANGELOG.md'
  spec.metadata['source_code_uri'] = 'https://github.com/envylabs/faraday-detailed_logger'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'faraday', '>= 0.16', '< 2'
  spec.add_runtime_dependency 'zeitwerk', '~> 2.0'

  spec.add_development_dependency 'appraisal', '~> 2.0'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'license_finder', '~> 6.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop-rails_config', '~> 1.3'
end
