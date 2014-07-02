# Faraday::DetailedLogger

A Faraday middleware used for providing debug- and info-level logging
information. The request and response logs follow very closely with cURL output
for ease of understanding.

**Caution:** Be careful about your log level settings when using this
middleware, _especially_ in a production environment. With a DEBUG level log
enabled, there will be information security concerns.

At a DEBUG level, the request and response headers and their bodies will be
logged. This means that if you have Authorization information or API keys in
your headers or are passing around sensitive information in the bodies, only an
INFO level or above should be used.

No headers or bodies are logged at an INFO or greater log level.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "faraday-detailed_logger"
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install faraday-detailed_logger
```

## Usage

Once required, the logger can be added to any Faraday connection by inserting
it into your connection's request/response stack:

```ruby
connection = Faraday.new(:url => "http://sushi.com") do |faraday|
  faraday.request  :url_encoded
  faraday.response :detailed_logger # <-- Inserts the logger into the connection.
  faraday.adapter  Faraday.default_adapter
end
```

By default, the Faraday::DetailedLogger will log to STDOUT. If this is not your
desired log location, simply provide any Logger-compatible object as a
parameter to the middleware definition:

```ruby
my_logger = Logger.new("logfile.log")
my_logger.level = Logger::INFO

connection = Faraday.new(:url => "http://sushi.com") do |faraday|
  faraday.request  :url_encoded
  faraday.response :detailed_logger, my_logger # <-- sets a custom logger.
  faraday.adapter  Faraday.default_adapter
end
```

Or, perhaps use your Rails logger:

```ruby
faraday.response :detailed_logger, Rails.logger
```

### Example output

#### Request logging

Log output for the request-portion of an HTTP interaction:

```plain
POST http://sushi.com/temaki
"User-Agent: Faraday v0.9.0\nAccept: application/json\nContent-Type: application/json\n\n{\"name\":\"Polar Bear\",\"ingredients\":[\"Tuna\",\"Salmon\",\"Cream Cheese\",\"Tempura Flakes\"],\"garnish\":\"Eel Sauce\"}"
```

The POST line is logged at an INFO level just before the request is transmitted
to the remote system. The second line containing the request headers and body
are logged at a DEBUG level.

#### Response logging

Log output for the response-portion of an HTTP interaction:
Response portion:

```plain
HTTP 202
"server: nginx\ndate: Tue, 01 Jul 2014 21:56:52 GMT\ncontent-type: application/json\ncontent-length: 17\nconnection: close\nstatus: 202 Accepted\n\n{\"order_id\":\"1\"}"
```

The HTTP status line is logged at an INFO level at the same time the response
is returned from the remote system. The second line containing the response
headers and body are logged at a DEBUG level.

## Contributing

1. Fork it ( https://github.com/envylabs/faraday-detailed_logger/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
