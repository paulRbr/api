module Api

  # All errors from this gem will inherit from this one.
  class Error < StandardError
    # Returns the appropriate Api::Error subclass based
    # on status and response message
    #
    # @param [Hash] response HTTP response
    # @return [Api::Error]
    def self.from_response(response)
      status = if response.respond_to?(:[])
                 response[:status].to_i
               else
                 response.status
               end

      if klass =  case status
                  when 400      then Api::BadRequest
                  when 401      then Api::Unauthorized
                  when 403      then Api::Unauthorized
                  when 404      then Api::NotFound
                  when 405      then Api::MethodNotAllowed
                  when 406      then Api::NotAcceptable
                  when 409      then Api::Conflict
                  when 415      then Api::UnsupportedMediaType
                  when 422      then Api::UnprocessableEntity
                  when 400..499 then Api::ClientError
                  when 500      then Api::InternalServerError
                  when 501      then Api::NotImplemented
                  when 502      then Api::BadGateway
                  when 503      then Api::ServiceUnavailable
                  when 500..599 then Api::ServerError
                  end
        klass.new(response)
      end
    end

    def initialize(response=nil)
      @response = response
      super
    end
  end

  class ClientError < Error; end
  class BadRequest < ClientError; end
  class Unauthorized < ClientError; end
  class Unauthorized < ClientError; end
  class NotFound < ClientError; end
  class MethodNotAllowed < ClientError; end
  class NotAcceptable < ClientError; end
  class Conflict < ClientError; end
  class UnsupportedMediaType < ClientError; end
  class UnprocessableEntity < ClientError; end
  class InternalServerError < ClientError; end
  class NotImplemented < ClientError; end
  class BadGateway < ClientError; end
  class ServiceUnavailable < ClientError; end
  class ServerError < ClientError; end

end
