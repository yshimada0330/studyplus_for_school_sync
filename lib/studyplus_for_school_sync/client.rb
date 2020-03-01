module StudyplusForSchoolSync
  class Client
    include Endpoint

    attr_accessor :access_token

    def initialize(base_url:, access_token: nil)
      @base_url = base_url
      @access_token = access_token
      @client = JSONClient.new
    end

    def get
    end

    def post(path:, params:)
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      headers['Authorization'] = "Bearer #{access_token}" if access_token
      @client.post("#{@base_url}/#{path}", body: params, header: headers)
    end

    def patch
    end
  end
end