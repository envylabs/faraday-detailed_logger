# frozen_string_literal: true

require "faraday"
require "faraday/detailed_logger/tagged_logging"

module Faraday
  module DetailedLogger
    # A Faraday middleware used for providing debug-level logging information.
    # The request and response logs follow very closely with cURL output for
    # ease of understanding.
    #
    # Be careful about your log level settings when using this middleware,
    # especially in a production environment. With a DEBUG level log enabled,
    # there will be potential information security concerns, because the
    # request and response headers and bodies will be logged out. At an INFO or
    # greater level, this is not a concern.
    #
    class Middleware < Faraday::Response::Middleware
      attr_reader :logger
      attr_reader :tags

      # Internal: Used as the Middleware's logger in the case that an explicit
      # logger is not provided.
      #
      # Returns a Logger instance.
      #
      def self.default_logger
        require "logger"
        ::Logger.new($stdout)
      end

      # Public: Initialize a new Logger middleware.
      #
      # app - A Faraday-compatible middleware stack or application.
      # logger - A Logger-compatible object to which the log information will
      #          be recorded.
      # tags - An optional array of tags to apply to the log output.
      #
      # Returns a Logger instance.
      #
      def initialize(app, logger = nil, *tags)
        super(app)
        @logger = TaggedLogging.new(logger || self.class.default_logger)
        @tags = tags
      end

      # Public: Used by Faraday to execute the middleware during the
      # request/response cycle.
      #
      # env - A Faraday-compatible request environment.
      #
      # Returns the result of the parent application execution.
      #
      def call(env)
        logger.tagged(*tags) do
          logger.info { "#{env[:method].upcase} #{env[:url]}" }
          logger.debug { curl_request_output(env) }
        end
        super
      rescue
        logger.error do
          "#{$!.class.name} - #{$!.message} (#{$!.backtrace.first})"
        end
        raise
      end

      # Internal: Used by Faraday as a callback hook to process a network
      # response after it has completed.
      #
      # env - A Faraday-compatible response environment.
      #
      # Returns nothing.
      #
      def on_complete(env)
        status = env[:status]

        logger.tagged(*tags) do
          log_response_status(status) { "HTTP #{status}" }
          logger.debug { curl_response_output(env) }
        end
      end

      private

        def curl_request_output(env)
          curl_output(env[:request_headers], env[:body]).inspect
        end

        def curl_response_output(env)
          curl_output(env[:response_headers], env[:body]).inspect
        end

        def curl_output(headers, body)
          string = headers.map { |k, v| "#{k}: #{v}" }.join("\n")
          string + "\n\n#{body}"
        end

        def log_response_status(status, &block)
          case status
          when 200..399
            logger.info(&block)
          else
            logger.warn(&block)
          end
        end
    end
  end
end

Faraday::Response.register_middleware(detailed_logger: Faraday::DetailedLogger::Middleware)
