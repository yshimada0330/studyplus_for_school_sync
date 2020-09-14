module StudyplusForSchoolSync
  class Authorizer
    def initialize(client_id: nil, redirect_uri: nil)
      @client_id = client_id || ENV["CLIENT_ID"]
      @redirect_uri = redirect_uri || ENV["REDIRECT_URI"]
      @response_type = "code"
      @scope = "learning_material_supplier"
    end
  end
end
