# vim: ft=ruby

require "simplecov-text"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::TextFormatter
]

SimpleCov.start do
  add_filter "/spec/"
  add_filter "/vendor/"

  add_group "Binaries", "/bin/"
  add_group "Extensions", "/ext/"
  add_group "Libraries", "/lib/"
  add_group "Vendor Libraries", "/vendor/"

  minimum_coverage 90
end
