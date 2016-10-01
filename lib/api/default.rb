require "api/default_options"

module Api

  # Default configuration options for {Client}
  module Default

    USER_AGENT = "Ruby toolkit API gem"

    class << self

      include Api::DefaultOptions

      # Default access token from ENV
      # @return [String]
      def access_token
        ENV['API_ACCESS_TOKEN']
      end

      # Default access token prefix
      # @return [String]
      def access_token_prefix
        "token"
      end

     # Default API endpoint from ENV
      # @return [String]
      def api_endpoint
        ENV['API_ENDPOINT']
      end

      # Default API version from ENV
      # @return [String]
      def api_version
        ENV['API_VERSION']
      end

      # Default pagination preference from ENV
      # @return [String]
      def auto_paginate
        ENV['API_AUTO_PAGINATE']
      end

      # Default login for basic auth from ENV
      # @return [String]
      def basic_login
        ENV['API_LOGIN']
      end

      # Default password for basic auth from ENV
      # @return [String]
      def basic_password
        ENV['API_PASSWORD']
      end

      # Default options for Faraday::Connection
      # @return [Hash]
      def connection_options
        {
          :headers => {
            :user_agent => user_agent
          }
        }
      end

      # Default options for Sawyer::Agent
      # @return [Hash]
      def sawyer_options
        {
          :links_parser => Sawyer::LinkParsers::Simple.new
        }
      end

      # Default pagination page size from ENV
      # @return [Fixnum] Page size
      def per_page
        page_size = ENV['API_PER_PAGE']

        page_size.to_i if page_size
      end

      # Default User-Agent header string from ENV or {USER_AGENT}
      # @return [String]
      def user_agent
        ENV['API_USER_AGENT'] || USER_AGENT
      end

    end
  end
end
