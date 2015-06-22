require 'simplecov'
require 'coveralls'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

require 'json'
require 'api'
require 'rspec'
require 'webmock/rspec'

WebMock.disable_net_connect!(:allow => 'coveralls.io')

require 'vcr'
VCR.configure do |c|
  c.hook_into :webmock
end

def api_url(url, opts = {})
  return url if url =~ /^http/

  basic_auth = opts[:basic_login] ? "#{opts[:basic_login]}:#{opts[:basic_password]}@" : ""
  url = File.join("http://#{basic_auth}example.org", url)
  uri = Addressable::URI.parse(url)

  uri.to_s
end

def token_client
  Api::Client.new(:access_token => test_token)
end

def test_token
  ENV.fetch 'API_TEST_TOKEN', 'x' * 20
end

def stub_delete(url, opts = {})
  stub_request(:delete, api_url(url, opts))
end

def stub_get(url, opts = {})
  stub_request(:get, api_url(url, opts))
end

def stub_head(url, opts = {})
  stub_request(:head, api_url(url, opts))
end

def stub_patch(url, opts = {})
  stub_request(:patch, api_url(url, opts))
end

def stub_post(url, opts = {})
  stub_request(:post, api_url(url, opts))
end

def stub_put(url, opts = {})
  stub_request(:put, api_url(url, opts))
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def json_response(file)
  {
    :body => fixture(file),
    :headers => {
      :content_type => 'application/json; charset=utf-8'
    }
  }
end
