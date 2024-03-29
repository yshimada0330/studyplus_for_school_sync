require "uri"
require "json"
require "faraday"
require "faraday/encoding"
require "faraday_middleware"

module StudyplusForSchoolSync
  # Handling access token
  class Token
    END_POINT = "/learning_material_supplier_api/v1/oauth/token"

    attr_reader :base_url, :client_id, :client_secret, :grant_type

    # @param base_url [String] API domain
    # @param client_id [String] Application ClientID
    # @param client_secret [String] Application Secret 
    def initialize(base_url:, client_id:, client_secret:)
      @base_url = base_url
      @client_id = client_id
      @client_secret = client_secret
      @conn = Faraday.new(headers: default_header) do |connection|
        connection.response :json
        connection.response :encoding
        connection.adapter Faraday.default_adapter
      end
    end
 
    # Creating a token from authorization code
    # @param authorization_code [String] Authorization Code
    # @param redirect_uri [String] Application Redirect URI
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

    # Refresh Token
    # @param refresh_token [String] Refresh token obtained during token generation
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
