# Faraday::DetailedLogger

[![Gem Version](https://badge.fury.io/rb/faraday-detailed_logger.svg)](https://badge.fury.io/rb/faraday-detailed_logger)
[![Tests](https://github.com/envylabs/faraday-detailed_logger/workflows/Tests/badge.svg)](https://github.com/envylabs/faraday-detailed_logger/actions?query=workflow%3ATests)

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
require 'faraday'
require 'faraday/detailed_logger'

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
require 'faraday'
require 'faraday/detailed_logger'
require 'logger'

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

Further, you might like to tag logged output to make it easily located in your
logs:

```ruby
faraday.response :detailed_logger, Rails.logger, "Sushi Request"
```

### Example output

Because logs generally work best with a single line of data per entry, the
DEBUG-level output which contains the headers and bodies is inspected prior to
logging. This crushes down and slightly manipulates the multi-line output one
would expect when performing a verbose cURL operation into a log-compatible
single line.

Below is a contrived example showing how this works. Presuming cURL generated
the following request and received the associated response:

```bash
$ curl -v -d "requestbody=content" http://sushi.com/temaki
> GET /temaki HTTP/1.1
> User-Agent: Faraday::DetailedLogger
> Host: sushi.com
> Content-Type: application/x-www-form-urlencoded
> 
> requestbody=content
>
< HTTP/1.1 200 OK
< Content-Type: application/json
< 
< {"order_id":"1"}
```

The Faraday::DetailedLogger would log something similar to the following, with
DEBUG-level logging enabled:

```plain
POST http://sushi.com/nigirizushi
"User-Agent: Faraday::DetailedLogger\nContent-Type: application/x-www-form-urlencoded\n\nrequestbody=content"
HTTP 200
"Content-Type: application/json\n\n{\"order_id\":\"1\"}"
```

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

Bug reports and pull requests are welcome on GitHub at https://github.com/envylabs/faraday-detailed_logger.

## License

The gem is available as open source under the terms of the [MIT License][].

### Dependency Licensing

The dependencies and sub-dependencies of this gem are checked to be available
for Private Use, Commercial Use, Modification, and Distribution:

* [2-Clause BSD License][]
* [Apache 2.0 License][]
* [MIT License][]
* [Ruby License][]

[2-Clause BSD License]: https://opensource.org/licenses/BSD-2-Clause
[Apache 2.0 License]: https://opensource.org/licenses/Apache-2.0
[MIT License]: https://opensource.org/licenses/MIT
[Ruby License]: https://en.wikipedia.org/wiki/Ruby_License
