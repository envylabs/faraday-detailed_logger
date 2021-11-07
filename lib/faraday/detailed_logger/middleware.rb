# frozen_string_literal: true

require 'faraday'
require 'faraday/detailed_logger/tagged_logging'

case
when Gem::Dependency.new('', '> 2.0.0.alpha.pre.1').match?('', Faraday::VERSION)
  require_relative 'middleware/current'
else
  require_relative 'middleware/legacy'
end
