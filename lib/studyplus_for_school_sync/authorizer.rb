module StudyplusForSchoolSync
  class Authorizer
    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
    RESPONSE_TYPE = "code"
    SCOPE = "learning_material_supplier"

    def initialize(client_id: nil, redirect_uri: nil)
      @client_id = client_id || ENV["CLIENT_ID"]
      @client = Faraday.new
    end

    def authorize
      path = "learning_material_supplier_api/v1/oauth/authorize"
      response = @client.get(build_url(path),
                             { client_id: @client_id, response_type: RESPONSE_TYPE, redirect_uri: OOB_URI, scope: SCOPE })
      # response.headers["location"]
    end

    private

    def build_url(path)
      URI.join(ENV["BASE_URL"], path)
    end
  end
end
