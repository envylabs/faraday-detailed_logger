# Faraday::DetailedLogger changelog

[![Gem Version](https://img.shields.io/gem/v/faraday-detailed_logger.svg)](http://rubygems.org/gems/faraday-detailed_logger)
[![Build Status](https://img.shields.io/travis/envylabs/faraday-detailed_logger/master.svg)](https://travis-ci.org/envylabs/faraday-detailed_logger)
[![Code Climate](https://img.shields.io/codeclimate/github/envylabs/faraday-detailed_logger.svg)](https://codeclimate.com/github/envylabs/faraday-detailed_logger)
[![Coverage Status](https://img.shields.io/coveralls/envylabs/faraday-detailed_logger.svg)](https://coveralls.io/r/envylabs/faraday-detailed_logger)
[![Dependency Status](https://gemnasium.com/envylabs/faraday-detailed_logger.svg)](https://gemnasium.com/envylabs/faraday-detailed_logger)

## [HEAD][] / unreleased

* Remove Logger `progname` support/configuration. Varying the progname appears
  to make logging in a syslog-like environment unnecessarily more difficult.

## [1.1.0][] / 2016-06-15

* Log HTTP 4XX and HTTP 5XX responses at a WARN level.

## [1.0.0][] / 2014-07-02

* Stable release.

[1.0.0]: https://github.com/envylabs/faraday-detailed_logger/tree/v1.0.0
[1.1.0]: https://github.com/envylabs/faraday-detailed_logger/compare/v1.0.0...v1.1.0
[HEAD]: https://github.com/envylabs/faraday-detailed_logger/compare/v1.1.0...master
