require "uri"
require "json"
require "faraday"
require "faraday/encoding"
require "faraday_middleware"

module StudyplusForSchoolSync
  class Client
    include Endpoint

    attr_accessor :access_token

    def initialize(base_url:, access_token: nil)
      @base_url = base_url
      @access_token = access_token
      @conn = Faraday.new(headers: default_header) do |connection|
        connection.response :json
        connection.response :encoding
        connection.adapter Faraday.default_adapter
      end
    end

    def get(path:, params: nil)
      @conn.get(build_url(path)) do |req|
        req.params = params if params
      end
    end

    def post(path:, params: nil)
      @conn.post(build_url(path)) do |req|
        req.body = params.to_json if params
      end
    end

    def put(path:, params: nil)
      @conn.put(build_url(path)) do |req|
        req.body = params.to_json if params
      end
    end

    def patch(path:, params: nil)
      @conn.patch(build_url(path)) do |req|
        req.body = params.to_json if params
      end
    end

    def delete(path:)
      @conn.delete(build_url(path))
    end
    
    private

    def build_url(path)
      URI.join(@base_url, path)
    end

    def default_header
      header = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      header['Authorization'] = "Bearer #{access_token}" if access_token 
      header
    end
  end
end
