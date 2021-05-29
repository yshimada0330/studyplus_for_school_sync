require "faraday"
require "faraday_middleware"

RSpec.describe StudyplusForSchoolSync::Endpoint::LearningMaterial do
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
  let(:name) { "教材名" }

  before do
    allow(Faraday).to receive(:new).and_return(conn)
  end

  context "#create_learning_material" do
    let(:response_body) do
      {
        "public_id" => "xxxx",
        "name" => "教材名",
        "unit" => "ページ",
        "image_url" => nil,
        "customer_uid" => nil,
      }
    end

    it "status=200" do
      stubs.post("#{base_url}/learning_material_supplier_api/v1/learning_materials") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/learning_materials")
        [
          200,
          { 'Content-Type': 'application/json' },
          '{
            "public_id": "xxxx",
            "name": "教材名",
            "unit": "ページ",
            "image_url": null,
            "customer_uid": null
          }',
        ]
      end

      expect(client.create_learning_material(name: name).body).to eq(response_body)
      stubs.verify_stubbed_calls
    end
  end

  context "#update_learning_material" do
    let(:learning_material_public_id) { "xxxxx" }
    let(:response_body) do
      {
        "public_id" => "xxxx",
        "name" => "教材名",
        "unit" => "ページ",
        "image_url" => nil,
        "customer_uid" => nil,
      }
    end

    it "status=200" do
      stubs.put("#{base_url}/learning_material_supplier_api/v1/learning_materials/#{learning_material_public_id}") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/learning_materials/#{learning_material_public_id}")
        [
          200,
          { 'Content-Type': 'application/json' },
          '{
            "public_id": "xxxx",
            "name": "教材名",
            "unit": "ページ",
            "image_url": null,
            "customer_uid": null
          }',
        ]
      end

      expect(client.update_learning_material(learning_material_public_id: learning_material_public_id, name: name).body).to eq(response_body)
      stubs.verify_stubbed_calls
    end
  end
end
 