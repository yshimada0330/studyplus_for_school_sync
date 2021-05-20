require "uri"
require "launchy"

module StudyplusForSchoolSync
  class Authorizer
    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
    RESPONSE_TYPE = "code"
    END_POINT = "learning_material_supplier_api/v1/oauth/authorize"
    DEFAULT_SCOPES = %w(learning_material_supplier lms_passcode_issue)

    attr_reader :client_id, :redirect_uri, :scopes

    def initialize(client_id: nil, redirect_uri: nil, scopes: DEFAULT_SCOPES)
      @client_id = client_id || ENV["CLIENT_ID"]
      @redirect_uri = redirect_uri || OOB_URI
      @scopes = scopes
    end

    def authorize
      query = URI.encode_www_form({ client_id: client_id, response_type: RESPONSE_TYPE, redirect_uri: redirect_uri, scope: scopes.join(" ") })
      Launchy.open(build_url(query))
    end

    private

    def build_url(query)
      "#{URI.join(ENV["BASE_URL"], END_POINT)}?#{query}"
    end
  end
end
