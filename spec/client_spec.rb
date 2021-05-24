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
  let(:partner_id) { "sample_partner_id" }

  before do
    allow(Faraday).to receive(:new).and_return(conn)
  end

  context "#tags" do
    let(:response_body) do
      {
        "tags" => {
          "data" => [
            {
              "customer_uid" => "abcde12345",
              "name" => "string",
              "public_id" => "string"
              }
          ],
          "meta" => { "current_page" => 0, "total_pages" => 0 }
        }
      }
    end

    it "status=200" do
      stubs.get("#{base_url}/learning_material_supplier_api/v1/partners/#{partner_id}/tags") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/partners/#{partner_id}/tags")
        [
          200,
          {
            'Content-Type': 'application/json' },
            '{"tags": {
                "data": [
                  {
                    "public_id": "string",
                    "customer_uid": "abcde12345",
                    "name": "string"
                  }
                ],
                "meta": {
                  "total_pages": 0,
                  "current_page": 0
                }
              }
            }'
        ]
      end

      expect(client.tags(partner_id: partner_id).body).to eq(response_body)
      stubs.verify_stubbed_calls
    end
  end
end