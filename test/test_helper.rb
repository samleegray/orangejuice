ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'simplecov'
require 'simplecov-json'
require 'simplecov-cobertura'

module SimpleCov
 module Formatter
   class MergedFormatter
     def format(result)
       SimpleCov::Formatter::HTMLFormatter.new.format(result)
       SimpleCov::Formatter::JSONFormatter.new.format(result)
       SimpleCov::Formatter::CoberturaFormatter.new.format(result)
     end
   end
 end
end
SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter

SimpleCov.start

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
