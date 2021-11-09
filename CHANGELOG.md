# Faraday::DetailedLogger changelog

[![Gem Version](https://badge.fury.io/rb/faraday-detailed_logger.svg)](https://badge.fury.io/rb/faraday-detailed_logger)
[![Tests](https://github.com/envylabs/faraday-detailed_logger/workflows/Tests/badge.svg)](https://github.com/envylabs/faraday-detailed_logger/actions?query=workflow%3ATests)

## [HEAD][] / unreleased

* Fix `Faraday::Error: :detailed_logger is not registered on Faraday::Response`
  by relocating middleware registration.
* Increase the low-end of the faraday dependency to `~> 0.16` for Ruby 3
  compatibility. Versions of faraday earlier than 0.16 are incompatible with
  Ruby 3's Proc interface.

## [2.4.0][] / 2021-11-06

* Use [zeitwerk](https://rubygems.org/gems/zeitwerk) autoloading.

## [2.3.0][] / 2020-02-11

* Sort the request and response headers when logging.

## [2.2.0][] / 2020-01-02

* Add support for faraday 1.0.

## [2.1.3][] / 2019-04-04

* Maintenance release, no functional changes.

## [2.1.2][] / 2017-08-21

* Update the middleware to allow the `logger` and `tags` to be publicly
  accessible. This is not necessarily intended to be developer-used, but rather
  fix warnings in older versions of Ruby.

## [2.1.1][] / 2017-01-07

* Require faraday `~> 0.8`. This change only makes explicit the minimum version
  of faraday which is supported.

## [2.1.0][] / 2016-10-12

* Catch StandardError exceptions to log and re-raise them.

## [2.0.0][] / 2016-07-08

* Remove Logger `progname` support/configuration. Varying the progname appears
  to make logging in a syslog-like environment unnecessarily more difficult.
* Add tagging support to the logger. Any number of tags may be given which will
  be prepended to all lines logged. This is largely follows the
  ActiveSupport::TaggedLogging log functionality. "Old" usages of this library
  will treat any previous `progname` strings as a tag and continue to record
  them to the log. Even though the progname is now logged as a tag, this is
  still considered a breaking change just in case system configurations were
  dependent on the progname for log output redirection (syslog).

## [1.1.0][] / 2016-06-15

* Log HTTP 4XX and HTTP 5XX responses at a WARN level.

## [1.0.0][] / 2014-07-02

* Stable release.

[1.0.0]: https://github.com/envylabs/faraday-detailed_logger/tree/v1.0.0
[1.1.0]: https://github.com/envylabs/faraday-detailed_logger/compare/v1.0.0...v1.1.0
[2.0.0]: https://github.com/envylabs/faraday-detailed_logger/compare/v1.1.0...v2.0.0
[2.1.0]: https://github.com/envylabs/faraday-detailed_logger/compare/v2.0.0...v2.1.0
[2.1.1]: https://github.com/envylabs/faraday-detailed_logger/compare/v2.1.0...v2.1.1
[2.1.2]: https://github.com/envylabs/faraday-detailed_logger/compare/v2.1.1...v2.1.2
[2.1.3]: https://github.com/envylabs/faraday-detailed_logger/compare/v2.1.2...v2.1.3
[2.2.0]: https://github.com/envylabs/faraday-detailed_logger/compare/v2.1.3...v2.2.0
[2.3.0]: https://github.com/envylabs/faraday-detailed_logger/compare/v2.2.0...v2.3.0
[2.4.0]: https://github.com/envylabs/faraday-detailed_logger/compare/v2.3.0...v2.4.0
[HEAD]: https://github.com/envylabs/faraday-detailed_logger/compare/v2.4.0...main
