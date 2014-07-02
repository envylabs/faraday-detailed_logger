require "faraday"

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

      def self.default_logger
        require "logger"
        ::Logger.new(STDOUT)
      end


      # Public: Initialize a new Logger middleware.
      #
      # app - A Faraday-compatible middleware stack or application.
      # logger - A Logger-compatible object to which the log information will
      #          be recorded.
      # progname - A String containing a program name to use when logging.
      #
      # Returns a Logger instance.
      #
      def initialize(app, logger = nil, progname = nil)
        super(app)
        @logger = logger || self.class.default_logger
        @progname = progname
      end

      # Public: Used by Faraday to execute the middleware during the
      # request/response cycle.
      #
      # env - A Faraday-compatible request environment.
      #
      # Returns the result of the parent application execution.
      #
      def call(env)
        @logger.info(@progname) { "#{env[:method].upcase} #{env[:url]}" }
        @logger.debug(@progname) { curl_output(env[:request_headers], env[:body]).inspect }
        super
      end

      # Internal: Used by Faraday as a callback hook to process a network
      # response after it has completed.
      #
      # env - A Faraday-compatible response environment.
      #
      # Returns nothing.
      #
      def on_complete(env)
        @logger.info(@progname) { "HTTP #{env[:status]}" }
        @logger.debug(@progname) { curl_output(env[:response_headers], env[:body]).inspect }
      end


      private


      def curl_output(headers, body)
        string = headers.collect { |k,v| "#{k}: #{v}" }.join("\n")
        string + "\n\n#{body}"
      end
    end
  end
end

Faraday::Response.register_middleware(:detailed_logger => Faraday::DetailedLogger::Middleware)
