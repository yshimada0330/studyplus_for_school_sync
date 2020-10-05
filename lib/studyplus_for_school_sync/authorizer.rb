module StudyplusForSchoolSync
  class Authorizer
    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'

    def initialize(client_id: nil, redirect_uri: nil)
      @client_id = client_id || ENV["CLIENT_ID"]
      @redirect_uri = redirect_uri || ENV["REDIRECT_URI"]
      @response_type = "code"
      @scope = "learning_material_supplier"
      @client = Faraday.new
    end

    def authorize
      path = "learning_material_supplier_api/v1/oauth/authorize"
      @client.get(build_url(path))
    end

    private

    def build_url(path)
      URI.join(ENV["BASE_URL"], path)
    end
  end
end
