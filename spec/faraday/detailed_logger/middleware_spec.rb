require "spec_helper"

require "logger"
require "stringio"

describe Faraday::DetailedLogger::Middleware do
  it "passes through the given progname to the logger" do
    logger = Logger.new(log = StringIO.new)

    expect {
      connection(logger, "TESTPROGNAME").get("/temaki")
    }.to change {
      log.rewind
      !!(log.read =~/\bTESTPROGNAME\b/)
    }.to(true)
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

  it "logs the response status code at an INFO level" do
    logger = Logger.new(log = StringIO.new)

    connection(logger).get("/temaki")
    log.rewind
    expect(log.read).to match(/\bINFO\b.+\bHTTP 200\b/)
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


  def connection(logger = nil, progname = nil)
    Faraday.new(:url => "http://sushi.com") do |builder|
      builder.request(:url_encoded)
      builder.response(:detailed_logger, logger, progname)
      builder.adapter(:test) do |stub|
        stub.get("/temaki") {
          [200, {"Content-Type" => "text/plain"}, "temaki"]
        }
        stub.post("/nigirizushi") {
          [200, {"Content-Type" => "application/json"}, "{\"order_id\":\"1\"}"]
        }
      end
    end
  end
end
