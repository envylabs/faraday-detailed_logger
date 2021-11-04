# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'faraday/detailed_logger'

RSpec.configure do |config|
  Kernel.srand config.seed

  config.disable_monkey_patching!
  config.example_status_persistence_file_path = '.rspec_status'
  config.filter_run :focus
  config.order = :random
  config.profile_examples = 10
  config.run_all_when_everything_filtered = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
