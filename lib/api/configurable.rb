module Api

  # Configuration options for {Client}, defaulting to values
  # in {Default}
  module Configurable
    # @!attribute [w] access_token
    #   @return [String] access token for authentication
    # @!attribute api_endpoint
    #   @return [String] Base URL for API requests.
    # @!attribute api_version
    #   @return [String] Version of the api. default: v1
    # @!attribute [w] basic_login
    #   @return [String] login for basic authentication
    # @!attribute [w] basic_password
    #   @return [String] password for basic authentication
    # @!attribute connection_options
    #   @see https://github.com/lostisland/faraday
    #   @return [Hash] Configure connection options for Faraday
    # @!attribute user_agent
    #   @return [String] Configure User-Agent header for requests.
    # @!attribute auto_paginate
    #   @return [Boolean] Auto fetch next page of results until rate limit reached. Will only work with an Hypermedia API.
    # @!attribute per_page
    #   @return [String] Configure page size for paginated results. API default: 30

    attr_accessor :access_token, :basic_login, :basic_password, :connection_options, :user_agent, :auto_paginate, :per_page
    attr_writer :api_endpoint, :api_version

    class << self

      # List of configurable keys for {Api::Client}
      # @return [Array] of option keys
      def keys
        @keys ||= [
          :access_token,
          :api_endpoint,
          :api_version,
          :auto_paginate,
          :basic_login,
          :basic_password,
          :connection_options,
          :per_page,
          :user_agent,
        ]
      end
    end

    # Set configuration options using a block
    def configure
      yield self
    end

    # Compares client options to a Hash of requested options
    #
    # @param opts [Hash] Options to compare with current client options
    # @return [Boolean]
    def same_options?(opts)
      opts.hash == options.hash
    end

    # Reset configuration options to default values
    def reset!(options = {})
      default_class = module_defaults || class_defaults
      Api::Configurable.keys.each do |key|
        value = options[key] || default_class.options[key] || Api::Default.options[key]
        instance_variable_set(:"@#{key}", value)
      end
      self
    end

    def api_endpoint
      File.join(@api_endpoint, "")
    end

    def api_version
      if @api_version.nil?
        ""
      else
        File.join(@api_version, "")
      end
    end

    private

    def options
      Hash[Api::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end

    def module_defaults
      try_defaults("#{self}::Default")
    end

    def class_defaults
      try_defaults("#{self.class.to_s.split("::").first}::Default")
    end

    def try_defaults(object_name)
      Object.const_get(object_name)
    rescue NameError => _e
      nil
    end
  end
end
