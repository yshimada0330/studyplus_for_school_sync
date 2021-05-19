require "uri"
require "json"
require "faraday"
require "faraday/encoding"

module StudyplusForSchoolSync
  class Token

    END_POINT = "/learning_material_supplier_api/v1/oauth/token"

    attr_reader :base_url, :client_id, :client_secret, :grant_type

    def initialize(base_url:, client_id:, client_secret:)
      @base_url = base_url
      @client_id = client_id
      @client_secret = client_secret
      @conn = Faraday.new(headers: default_header) do |connection|
        connection.response :encoding
        connection.adapter Faraday.default_adapter
      end
    end
 
    def create(authorization_code:, redirect_uri:)
      post(
        path: END_POINT,
        params: {
          client_id: client_id,
          client_secret: client_secret,
          redirect_uri: redirect_uri,
          grant_type: "authorization_code",
          code: authorization_code,
        }
      )
    end

    def refresh(refresh_token)
      post(
        path: END_POINT,
        params: {
          client_id: client_id,
          client_secret: client_secret,
          grant_type: "refresh_token",
          refresh_token: refresh_token,
        }
      )
    end

    private

    def post(path:, params: nil)
      @conn.post(build_url(path)) do |req|
        req.body = params.to_json if params
      end
    end

    def build_url(path)
      URI.join(base_url, path)
    end

    def default_header
      { "Accept" => "application/json", "Content-Type" => "application/json" }
    end
  end
end
