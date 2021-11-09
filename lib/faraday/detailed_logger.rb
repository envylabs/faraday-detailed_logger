# frozen_string_literal: true

require 'faraday/detailed_logger/version'
require 'faraday/detailed_logger/middleware'

require 'faraday'

module Faraday
  module DetailedLogger
  end
end

Faraday::Response.register_middleware(detailed_logger: Faraday::DetailedLogger::Middleware)
