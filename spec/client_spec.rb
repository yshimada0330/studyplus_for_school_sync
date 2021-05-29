require "faraday"
require "faraday_middleware"

RSpec.describe StudyplusForSchoolSync::Client do
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:conn) do
    Faraday.new do |connection|
      connection.response :json
      connection.adapter(:test, stubs)
    end
  end

  let(:base_url) { "http://example.com" }
  let(:access_token) { "sample_token" }
  let(:client) { StudyplusForSchoolSync::Client.new(base_url: base_url, access_token: access_token) }

  before do
    allow(Faraday).to receive(:new).and_return(conn)
  end

  context "#get" do
    let(:response_body) do
      { "test" => "sample" }
    end

    it "status=200" do
      stubs.get("#{base_url}/test") do |env|
        expect(env.url.path).to eq("/test")
        [
          200,
          { 'Content-Type': 'application/json' },
          '{ "test": "sample" }'
        ]
      end

      expect(client.get(path: "#{base_url}/test").body).to eq(response_body)
      stubs.verify_stubbed_calls
    end
  end
end