require "uri"
require "launchy"

module StudyplusForSchoolSync
  # Retrieve Authorization Code
  class Authorizer
    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
    RESPONSE_TYPE = "code"
    END_POINT = "learning_material_supplier_api/v1/oauth/authorize"
    DEFAULT_SCOPES = %w(learning_material_supplier lms_passcode_issue)

    attr_reader :base_url, :client_id, :redirect_uri, :scopes

    # @param base_url [String] API domain
    # @param client_id [String] ApplicationClientID
    # @param redirect_uri [String]
    # @param scopes [Array]
    def initialize(base_url:, client_id:, redirect_uri: nil, scopes: DEFAULT_SCOPES)
      @base_url = base_url
      @client_id = client_id
      @redirect_uri = redirect_uri || OOB_URI
      @scopes = scopes
    end

    # Launch the browser to get the Authorization Code and authorize it.
    def authorize
      query = URI.encode_www_form({ client_id: client_id, response_type: RESPONSE_TYPE, redirect_uri: redirect_uri, scope: scopes.join(" ") })
      Launchy.open(build_url(query))
    end

    private

    def build_url(query)
      "#{URI.join(base_url, END_POINT)}?#{query}"
    end
  end
end
