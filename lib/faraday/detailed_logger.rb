# frozen_string_literal: true

require 'zeitwerk'
loader = Zeitwerk::Loader.new
loader.tag = 'faraday-detailed_logger'
loader.inflector = Zeitwerk::GemInflector.new(__FILE__)
loader.push_dir(File.join(__dir__, '..'))
loader.ignore(__FILE__)
loader.setup

require 'faraday'

module Faraday
  module DetailedLogger
  end
end

Faraday::Response.register_middleware(detailed_logger: Faraday::DetailedLogger::Middleware)
