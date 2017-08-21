# Faraday::DetailedLogger changelog

[![Gem Version](https://img.shields.io/gem/v/faraday-detailed_logger.svg)](https://rubygems.org/gems/faraday-detailed_logger)
[![Build Status](https://img.shields.io/travis/envylabs/faraday-detailed_logger/master.svg)](https://travis-ci.org/envylabs/faraday-detailed_logger)
[![Code Climate](https://img.shields.io/codeclimate/github/envylabs/faraday-detailed_logger.svg)](https://codeclimate.com/github/envylabs/faraday-detailed_logger)
[![Coverage Status](https://img.shields.io/coveralls/envylabs/faraday-detailed_logger.svg)](https://coveralls.io/r/envylabs/faraday-detailed_logger)
[![Dependency Status](https://gemnasium.com/envylabs/faraday-detailed_logger.svg)](https://gemnasium.com/envylabs/faraday-detailed_logger)
[![Inline docs](https://inch-ci.org/github/envylabs/faraday-detailed_logger.svg?branch=master)](https://inch-ci.org/github/envylabs/faraday-detailed_logger)

## [HEAD][] / unreleased

* No significant changes.

## [2.1.2][] / 2016-08-21

* Update the middleware to allow the `logger` and `tags` to be publicly
  accessible. This is not necessarily intended to be developer-used, but rather
  fix warnings in older versions of Ruby.

## [2.1.1][] / 2016-01-07

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
[HEAD]: https://github.com/envylabs/faraday-detailed_logger/compare/v2.1.2...master
