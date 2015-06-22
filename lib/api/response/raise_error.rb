require 'faraday'
require 'api/errors'

module Api
  # Faraday response middleware
  module Response

    # This class raises an Api-flavored exception based
    # HTTP status codes returned by the API
    class RaiseError < Faraday::Response::Middleware

      class << self
        def try(response)
          @middleware ||= RaiseError.new
          @middleware.send(:on_complete, response)
        end
      end

      private

      def on_complete(response)
        if error = Api::Error.from_response(response)
          raise error
        end
      end
    end
  end
end
