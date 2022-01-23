# frozen_string_literal: true

module Faraday
  module DetailedLogger
    module CurlFormatter
      def self.request(env)
        "#{env[:method].upcase} #{env[:url]}"
      end

      def self.request_body(env)
        curl_output(env[:request_headers], env[:body]).inspect
      end

      def self.response(env)
        "HTTP #{env[:status]}"
      end

      def self.response_body(env)
        curl_output(env[:response_headers], env[:body]).inspect
      end

      private

      def self.curl_output(headers, body)
        string = headers.to_a.sort_by(&:first).map { |k, v| "#{k}: #{v}" }.join("\n")
        string + "\n\n#{body}"
      end
    end
  end
end
