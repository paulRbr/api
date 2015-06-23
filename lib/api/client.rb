require 'api/authentication'
require 'api/configurable'
require 'api/connection'

module Api

  # Client for an API
  class Client

    include Api::Authentication
    include Api::Configurable
    include Api::Connection

     # Header keys that can be passed in options hash to {#get}
    CONVENIENCE_HEADERS = Set.new([:accept, :content_type])

    def initialize(options = {})
      reset!(options)
    end

    # Text representation of the client, masking tokens and passwords
    #
    # @return [String]
    def inspect
      inspected = super

      # mask password
      inspected = inspected.gsub! @basic_password, "*******" if @basic_password
      # Only show last 4 of token, secret
      if @access_token
        inspected = inspected.gsub! @access_token, "#{'*'*36}#{@access_token[36..-1]}"
      end

      inspected
    end

  end
end
