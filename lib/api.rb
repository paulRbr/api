$LOAD_PATH.unshift(File.dirname(__FILE__)) unless
  $LOAD_PATH.include?(File.dirname(__FILE__)) || $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'json'

require 'api/errors'
require 'api/default'
require 'api/configurable'
require 'api/client'
require 'api/version'


# Ruby toolkit to build API clients
module Api

  # class << self
  #   include Api::Configurable

  #   # API client based on configured options {Configurable}
  #   #
  #   # @return [Api::Client] API wrapper
  #   def client
  #     return @client if defined?(@client) && @client.same_options?(options)
  #     @client = Api::Client.new(options)
  #   end

  #   private

  #   def respond_to_missing?(method_name, include_private=false)
  #     client.respond_to?(method_name, include_private)
  #   end

  #   def method_missing(method_name, *args, &block)
  #     if client.respond_to?(method_name)
  #       return client.send(method_name, *args, &block)
  #     end

  #     super
  #   end

  # end
end

# Api.reset!
