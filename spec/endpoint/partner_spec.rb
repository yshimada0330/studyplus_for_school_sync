require "faraday"
require "faraday_middleware"

RSpec.describe StudyplusForSchoolSync::Endpoint::Partner do
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

  context "#create_partner" do
    let(:school_name) { "schoolA" }
    let(:response_body) do
      {
        "public_id" => "abcde12345",
        "customer_uid" => nil,
      }
    end

    it "status=200" do
      stubs.post("#{base_url}/learning_material_supplier_api/v1/partners") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/partners")
        [
          200,
          { 'Content-Type': 'application/json' },
          '{
              "public_id": "abcde12345",
              "customer_uid": null
           }',
        ]
      end

      expect(client.create_partner(school_name: school_name).body).to eq(response_body)
      stubs.verify_stubbed_calls
    end
  end

  context "#create_student" do
    let(:partner_public_id) { "abcde12345" }
    let(:last_name) { "スタプラ" }
    let(:first_name) { "太郎" }
    let(:last_name_kana) { "スタプラ" }
    let(:first_name_kana) { "タロウ" }
    let(:response_body) do
      {
        "public_id" => "abcde12345",
        "customer_uid" => nil,
      }
    end

    it "status=200" do
      stubs.post("#{base_url}/learning_material_supplier_api/v1/partners/#{partner_public_id}/students") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/partners/#{partner_public_id}/students")
        [
          200,
          { 'Content-Type': 'application/json' },
          '{
              "public_id": "abcde12345",
              "customer_uid": null 
           }',
        ]
      end

      expect(client.create_student(
        partner_public_id: partner_public_id,
        last_name: last_name,
        first_name: first_name,
        last_name_kana: last_name_kana,
        first_name_kana: first_name_kana
      ).body).to eq(response_body)
      stubs.verify_stubbed_calls
    end
  end

  context "#tags" do
    let(:partner_id) { "sample_partner_id" }
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
          { 'Content-Type': 'application/json' },
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

  context "#create_tag" do
    let(:partner_id) { "sample_partner_id" }
    let(:name) { "sample" }
    let(:response_body) do
      {
        "tag" => {
          "public_id" => "abcde12345",
          "customer_uid" => nil,
          "name" => "sample",
         }
      }
    end

    it "status=200" do
      stubs.post("#{base_url}/learning_material_supplier_api/v1/partners/#{partner_id}/tags") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/partners/#{partner_id}/tags")
        [
          200,
          { 'Content-Type': 'application/json' },
          '{
            "tag": {
              "public_id": "abcde12345",
              "customer_uid": null,
              "name": "sample"
            }
          }',
        ]
      end

      expect(client.create_tag(partner_id: partner_id, name: name).body).to eq(response_body)
      stubs.verify_stubbed_calls
    end
  end

  context "#update_tag" do
    let(:partner_id) { "sample_partner_id" }
    let(:tag_id) { "sample_tag_id" }
    let(:name) { "sample" }
    let(:response_body) do
      {
        "tag" => {
          "public_id" => "abcde12345",
          "customer_uid" => nil,
          "name" => "sample",
         }
      }
    end

    it "status=200" do
      stubs.patch("#{base_url}/learning_material_supplier_api/v1/partners/#{partner_id}/tags/#{tag_id}") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/partners/#{partner_id}/tags/#{tag_id}")
        [
          200,
          { 'Content-Type': 'application/json' },
          '{
            "tag": {
              "public_id": "abcde12345",
              "customer_uid": null,
              "name": "sample"
            }
          }',
        ]
      end

      expect(client.update_tag(partner_id: partner_id, tag_id: tag_id, name: name).body).to eq(response_body)
      stubs.verify_stubbed_calls
    end
  end

  context "#delete_tag" do
    let(:partner_id) { "sample_partner_id" }
    let(:tag_id) { "sample_tag_id" }
    let(:name) { "sample" }

    it "status=200" do
      stubs.delete("#{base_url}/learning_material_supplier_api/v1/partners/#{partner_id}/tags/#{tag_id}") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/partners/#{partner_id}/tags/#{tag_id}")
        [
          204,
          { 'Content-Type': 'application/json' },
        ]
      end

      expect(client.delete_tag(partner_id: partner_id, tag_id: tag_id).body).to be_nil 
      stubs.verify_stubbed_calls
    end
  end
end
