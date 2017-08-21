# frozen_string_literal: true

require "logger"

module Faraday
  module DetailedLogger
    # This was largely lifted from ActiveSupport::TaggedLogging. Modifications
    # made to remove ActiveSupport dependencies (blank?, delegation, and
    # ActiveSupport::Logger).
    #
    module TaggedLogging
      extend Forwardable

      module Formatter
        BLANK = lambda do |value|
          value.respond_to?(:empty?) ? !!value.empty? : !value
        end

        def call(severity, timestamp, progname, msg)
          super(severity, timestamp, progname, "#{tags_text}#{msg}")
        end

        def tagged(*tags)
          new_tags = push_tags(*tags)
          yield self
        ensure
          pop_tags(new_tags.size)
        end

        def push_tags(*tags)
          tags.flatten.reject(&BLANK).tap do |new_tags|
            current_tags.concat new_tags
          end
        end

        def pop_tags(size = 1)
          current_tags.pop size
        end

        def clear_tags!
          current_tags.clear
        end

        def current_tags
          @thread_key ||= "faraday_detailed_logger_tags:#{object_id}"
          Thread.current[@thread_key] ||= []
        end

        private

          def tags_text
            tags = current_tags
            if tags.any?
              tags.map { |tag| "[#{tag}] " }.join
            end
          end
      end

      def self.new(logger)
        unless logger.respond_to?(:tagged)
          logger.formatter ||= ::Logger::Formatter.new
          logger.formatter.extend Formatter
          logger.extend(self)
        end

        logger
      end

      def tagged(*tags)
        formatter.tagged(*tags) { yield self }
      end

      def flush
        clear_tags!
        super if defined?(super)
      end
    end
  end
end
