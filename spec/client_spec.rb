require 'spec_helper'

describe Api::Client do
  before do
    VCR.turn_off!
    @client = Api::Client.new
  end

  it "sets defaults" do
    Api::Configurable.keys.each do |key|
      expect(@client.instance_variable_get(:"@#{key}")).to eq(Api::Default.send(key))
    end
  end

  describe ".configure" do
    Api::Configurable.keys.each do |key|
      it "sets the #{key.to_s.gsub('_', ' ')}" do
        @client.configure do |config|
          config.send("#{key}=", key)
        end
        expect(@client.instance_variable_get(:"@#{key}")).to eq(key)
      end
    end
  end

  describe "A client implementation" do
    before do
      module MyApi
        class Client < Api::Client
        end

        module Default
          class << self
            include Api::DefaultOptions

            def api_endpoint
              "http://example.org"
            end
            def method_missing(_method)
              ""
            end
          end
        end
      end

      @client = MyApi::Client.new
    end

    describe ".root" do
      it "gets the root of the api" do
        stub_get('/').to_return(:status => 200)
        expect { @client.root }.to_not raise_error
        expect(@client.last_response.data).to eq('')
      end
    end

    context "with no authentication" do
      it "does requests with no authorization header" do
        stub_head('/hello').to_return(:status => 200)
        expect { @client.head('/hello') }.to_not raise_error
        expect(@client.last_response.headers).to eq({})
      end
    end

    context "with token authentication" do
      before do
        @client.configure do |c|
          c.access_token = "token123"
        end
      end

      it "does requests with a token authorization header" do
        stub_post('/hello').with(:headers => { 'Authorization' => 'token token123' }).to_return(:status => 200)
        expect { @client.post('/hello') }.to_not raise_error
        expect(@client.last_response.data).to eq('')
      end
    end

     context "with basic authentication" do
      before do
        @client.configure do |c|
          c.basic_login = "login"
          c.basic_password = "password"
        end
      end

      it "does requests with basic auth method" do
        stub_put('/hello', basic_login: "login", basic_password: "password").to_return(:status => 200)
        expect { @client.put('/hello') }.to_not raise_error
        expect(@client.last_response.data).to eq('')
      end
    end

    context "error handling" do
      it "raises on 404" do
        stub_delete('/booya').to_return(:status => 404)
        expect { @client.delete('/booya') }.to raise_error Api::NotFound
      end

      it "raises on 401" do
        stub_patch('/forbidden').to_return(:status => 401)
        expect { @client.patch('/forbidden') }.to raise_error Api::Unauthorized
      end

      it "raises on 500" do
        stub_get('/boom').to_return(:status => 500)
        expect { @client.get('/boom') }.to raise_error Api::InternalServerError
      end

      it "raises for all supported codes" do
        %w(400 403 405 406 409 415 422 499 501 502 503 504).each do |code|
          stub_get('/error').to_return(:status => code.to_i)
          expect { @client.get('/error') }.to raise_error
        end
      end
    end
  end
end
