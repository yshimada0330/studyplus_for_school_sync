module StudyplusForSchoolSync
  class Client
    def initialize(base_url:)
      @base_url = base_url
      @client = JSONClient.new
    end

    def get
    end

    def post(access_token:, path:, params:)
      headers = { 'Authorization' => "Bearer #{access_token}",'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      @client.post("#{@base_url}/#{path}", body: params, header: headers)
    end

    def patch
    end
  end
end