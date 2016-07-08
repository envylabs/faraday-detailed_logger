require "spec_helper"

require "logger"
require "stringio"

describe Faraday::DetailedLogger::Middleware do
  it "logs with the configured tags prepended to each line" do
    logger = Logger.new(log = StringIO.new)

    connection(logger, %w[ebi]).get("/temaki")
    log.rewind
    log.readlines.each do |line|
      expect(line).to match(/: \[ebi\] /)
    end
  end

  it "logs the request method at an INFO level" do
    logger = Logger.new(log = StringIO.new)

    connection(logger).get("/temaki")
    log.rewind
    expect(log.read).to match(/\bINFO\b.+\bGET\b/)
  end

  it "logs the request URI at an INFO level" do
    logger = Logger.new(log = StringIO.new)

    connection(logger).get("/temaki")
    log.rewind
    expect(log.read).to match(/\bINFO\b.+\bhttp:\/\/sushi.com\/temaki\b/)
  end

  it "logs a cURL-like request package at a DEBUG level" do
    logger = Logger.new(log = StringIO.new)

    connection(logger).post("/nigirizushi", {"body" => "content"}, {:user_agent => "Faraday::DetailedLogger"})
    log.rewind
    curl = <<-CURL.strip
User-Agent: Faraday::DetailedLogger
Content-Type: application/x-www-form-urlencoded

body=content
CURL
    expect(log.read).to match(/\bDEBUG\b.+#{Regexp.escape(curl.inspect)}/)
  end

  it "logs a 2XX response status code at an INFO level" do
    logger = Logger.new(log = StringIO.new)

    connection(logger).get("/oaiso", {c: 200})
    log.rewind
    expect(log.read).to match(/\bINFO\b.+\bHTTP 200\b/)
  end

  it "logs a 3XX response status code at an INFO level" do
    logger = Logger.new(log = StringIO.new)

    connection(logger).get("/oaiso", {c: 301})
    log.rewind
    expect(log.read).to match(/\bINFO\b.+\bHTTP 301\b/)
  end

  it "logs a 4XX response status code at a WARN level" do
    logger = Logger.new(log = StringIO.new)

    connection(logger).get("/oaiso", {c: 401})
    log.rewind
    expect(log.read).to match(/\bWARN\b.+\bHTTP 401\b/)
  end

  it "logs a 5XX response status code at an WARN level" do
    logger = Logger.new(log = StringIO.new)

    connection(logger).get("/oaiso", {c: 500})
    log.rewind
    expect(log.read).to match(/\bWARN\b.+\bHTTP 500\b/)
  end

  it "logs a cURL-like response package at a DEBUG level" do
    logger = Logger.new(log = StringIO.new)

    connection(logger).post("/nigirizushi")
    log.rewind
    curl = <<-CURL.strip
Content-Type: application/json

{"order_id":"1"}
CURL
    expect(log.read).to match(/\bDEBUG\b.+#{Regexp.escape(curl.inspect)}/)
  end


  private


  def connection(logger = nil, *tags)
    Faraday.new(:url => "http://sushi.com") do |builder|
      builder.request(:url_encoded)
      builder.response(:detailed_logger, logger, *tags)
      builder.adapter(:test) do |stub|
        stub.get("/temaki") {
          [200, {"Content-Type" => "text/plain"}, "temaki"]
        }
        stub.post("/nigirizushi") {
          [200, {"Content-Type" => "application/json"}, "{\"order_id\":\"1\"}"]
        }
        stub.get("/oaiso") { |env|
          code = env.respond_to?(:params) ? env.params["c"] : env.fetch(:params).fetch("c")
          [code.to_i, {"Content-Type" => "application/json"}, code]
        }
      end
    end
  end
end
