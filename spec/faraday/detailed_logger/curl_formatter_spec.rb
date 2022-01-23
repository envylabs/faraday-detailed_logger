# frozen_string_literal: true

RSpec.describe Faraday::DetailedLogger::CurlFormatter do
  context '#request' do
    it 'returns the HTTP verb and URL' do
      env = Faraday::Env.new
      env[:method] = 'GET'
      env[:url] = 'http://sushi.com/temaki'

      expect(described_class.request(env)).to eq('GET http://sushi.com/temaki')
    end
  end

  context '#request_body' do
    it 'returns a cURL-like request structure' do
      env = Faraday::Env.new
      env[:body] = 'body=content'
      env[:method] = 'POST'
      env[:request_headers] = {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'User-Agent' => 'Faraday::DetailedLogger'
      }
      env[:url] = 'http://sushi.com/temaki'

      expected = <<~EXPECTED.strip.inspect
        Content-Type: application/x-www-form-urlencoded
        User-Agent: Faraday::DetailedLogger

        body=content
      EXPECTED

      expect(described_class.request_body(env)).to eq(expected)
    end
  end

  context '#response' do
    it 'returns the HTTP status code' do
      env = Faraday::Env.new
      env[:status] = 200

      expect(described_class.response(env)).to eq('HTTP 200')
    end
  end

  context '#response_body' do
    it 'returns a cURL-like response structure' do
      env = Faraday::Env.new
      env[:body] = '{"id":"1"}'
      env[:response_headers] = { 'Content-Type' => 'application/json' }

      expected = <<~EXPECTED.strip.inspect
        Content-Type: application/json

        {"id":"1"}
      EXPECTED

      expect(described_class.response_body(env)).to eq(expected)
    end
  end
end
