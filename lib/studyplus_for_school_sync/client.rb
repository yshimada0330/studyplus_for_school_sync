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

    def post(path:, params: nil)
      @client.post("#{@base_url}/#{path}", body: params, header: default_header)
    end

    def put(path:, params: nil)
      @client.put("#{@base_url}/#{path}", body: params, header: default_header)
    end
    
    private

    def default_header
      header = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      header['Authorization'] = "Bearer #{access_token}" if access_token 
      header
    end
  end
end