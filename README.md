# API wrapper

## Description

This gem is a generic client for HTTP based APIs.

## Installation

You can use this gem in your project by specifying it in your `Gemfile`:

```
gem "api"
```

or simply install it via the CLI:

```
gem install api
```

## Usage

Create your own API client my inheriting from the Api::Client class and defining all mandatory defaults attributes in a Namespace::Default module as such:

```
module ExampleApi
  class Client < Api::Client
    # Include mandatory modules
    include Api::Configurable
    include Api::Connection
    include Api::Authentication
  end

  module Default
    API_ENDPOINT = "http://example.org".freeze

    class << self

      # Include mandatory module
      include Api::DefaultOptions

      def api_endpoint
        API_ENDPOINT
      end

    end
 end
end
```

Now get started requesting stuff from your api:

```
c = ExampleApi::Client.new
 => ...

c.root
 => "<!doctype html>\n..."

c.last_response.data == c.get("/")
 => true

c.get("/boom")
 raises Api::NotFound: #<Sawyer::Response:0x000000029bb908>
```

## License

Code licensed under [MIT-LICENSE](https://github.com/paulrbr/api/blob/master/MIT-LICENSE)
