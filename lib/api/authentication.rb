module Api

  # Authentication methods for {Api::Client}
  module Authentication

    # Indicates if the client was supplied an
    # access token
    #
    # @return [Boolean]
    def token_authenticated?
      !@access_token.nil? && !@access_token.empty?
    end

    # Indicates if the client was supplied basic auth
    # credentials
    #
    # @return [Boolean]
    def basic_authenticated?
      !@basic_login.nil? && !@basic_login.empty? &&
        !@basic_password.nil? && !@basic_password.empty?
    end

  end
end
