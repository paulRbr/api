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

  end
end
