require "faraday"
require "faraday_middleware"

RSpec.describe StudyplusForSchoolSync::Endpoint::Student do
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

  context "#create_passcode" do
    let(:student_id) { "student_id" }

    it "status=200" do
      stubs.post("#{base_url}/learning_material_supplier_api/v1/students/#{student_id}/passcode") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/students/#{student_id}/passcode")
        [
          200,
          { 'Content-Type': 'application/json' },
          '{
            "code": "abc123"
           }',
        ]
      end

      expect(client.create_passcode(student_id).body).to eq({ "code" => "abc123" })
      stubs.verify_stubbed_calls
    end
  end

  context "#inactivate_passcode" do
    let(:student_id) { "student_id" }

    it "status=204" do
      stubs.delete("#{base_url}/learning_material_supplier_api/v1/students/#{student_id}/passcode") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/students/#{student_id}/passcode")
        [
          204,
          { 'Content-Type': 'application/json' },
        ]
      end

      expect(client.inactivate_passcode(student_id).body).to be_nil 
      stubs.verify_stubbed_calls
    end
  end

  context "#create_study_record" do
    let(:learning_material_public_id) { "sample_id" }
    let(:student_public_id) { "sample_id" }
    let(:recorded_at) { "2020/02/02 20:00:00" }

    it "status=200" do
      stubs.post("#{base_url}/learning_material_supplier_api/v1/study_records") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/study_records")
        [
          200,
          { 'Content-Type': 'application/json' },
          '{}',
        ]
      end

      expect(client.create_study_record(
        learning_material_public_id: learning_material_public_id,
        student_public_id: student_public_id,
        recorded_at: recorded_at
        ).body).to eq({})
      stubs.verify_stubbed_calls
    end
  end

  context "#student_tags" do
    let(:student_id) { "student_id" }
    let(:response_body) do
      {
        "tags" => [
          {
            "public_id" => "abcde12345",
            "customer_uid" => nil,
            "name" => "tag",
          }
        ]
      }
    end

    it "status=200" do
      stubs.get("#{base_url}/learning_material_supplier_api/v1/students/#{student_id}/tags") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/students/#{student_id}/tags")
        [
          200,
          { 'Content-Type': 'application/json' },
          '{
            "tags": [
              {
                "public_id": "abcde12345",
                "customer_uid": null,
                "name": "tag"
              }
            ]
          }'
        ]
      end

      expect(client.student_tags(student_id: student_id).body).to eq(response_body)
      stubs.verify_stubbed_calls
    end
  end

  context "#attach_student_tag" do
    let(:student_id) { "student_id" }
    let(:tag_id) { "student_id" }

    it "status=204" do
      stubs.put("#{base_url}/learning_material_supplier_api/v1/students/#{student_id}/tags/#{tag_id}") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/students/#{student_id}/tags/#{tag_id}")
        [
          204,
          { 'Content-Type': 'application/json' },
        ]
      end

      expect(client.attach_student_tag(student_id: student_id, tag_id: tag_id).body).to be_nil 
      stubs.verify_stubbed_calls
    end
  end

  context "#detach_student_tag" do
    let(:student_id) { "student_id" }
    let(:tag_id) { "student_id" }

    it "status=204" do
      stubs.delete("#{base_url}/learning_material_supplier_api/v1/students/#{student_id}/tags/#{tag_id}") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/students/#{student_id}/tags/#{tag_id}")
        [
          204,
          { 'Content-Type': 'application/json' },
        ]
      end

      expect(client.detach_student_tag(student_id: student_id, tag_id: tag_id).body).to be_nil 
      stubs.verify_stubbed_calls
    end
  end

  context "#student_transfer" do
    let(:student_id) { "sample_id" }
    let(:transfer_id) { "sample_id" }
    let(:response_body) do
      {
        "student_transfer" => {
          "id" => "sample_id",
          "student" => {
            "public_id" => "sample_id",
            "customer_uid" => "sample_customer_uid",
            "last_name" => "スタプラ",
            "first_name" => "太郎",
            "last_name_kana" => "スタプラ",
            "first_name_kana" => "タロウ",
            "school_type" => 2,
            "grade" => 1,
            "code" => "string"
          },
          "to_partner" => {
            "public_id" => "sample_id",
            "customer_uid" => "sample_customer_uid",
            "school_name" => "スタプラ学園",
            "name" => "御茶ノ水校",
            "timezone" => "Asia/Tokyo",
            "started_on" => "2020/01/01"
          },
          "job_status" => "pending",
          "started_at" => "2021-05-30T13:36:38.755Z",
          "completed_at" => "2021-05-30T13:36:38.755Z",
          "failed_at" => "2021-05-30T13:36:38.755Z"
        }
      }
    end

    it "status=200" do
      stubs.get("#{base_url}/learning_material_supplier_api/v1/students/#{student_id}/transfers/#{transfer_id}") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/students/#{student_id}/transfers/#{transfer_id}")
        [
          200,
          { 'Content-Type': 'application/json' },
          '{
            "student_transfer": {
              "id": "sample_id",
              "student": {
                "public_id": "sample_id",
                "customer_uid": "sample_customer_uid",
                "last_name": "スタプラ",
                "first_name": "太郎",
                "last_name_kana": "スタプラ",
                "first_name_kana": "タロウ",
                "school_type": 2,
                "grade": 1,
                "code": "string"
              },
              "to_partner": {
                "public_id": "sample_id",
                "customer_uid": "sample_customer_uid",
                "school_name": "スタプラ学園",
                "name": "御茶ノ水校",
                "timezone": "Asia/Tokyo",
                "started_on": "2020/01/01"
              },
              "job_status": "pending",
              "started_at": "2021-05-30T13:36:38.755Z",
              "completed_at": "2021-05-30T13:36:38.755Z",
              "failed_at": "2021-05-30T13:36:38.755Z"
            }
          }',
        ]
      end

      expect(client.student_transfer(student_id: student_id, transfer_id: transfer_id).body).to eq(response_body)
      stubs.verify_stubbed_calls
    end
  end

  context "#create_student_transfer" do
    let(:student_id) { "student_id" }
    let(:partner_id) { "partner_id" }

    it "status=204" do
      stubs.post("#{base_url}/learning_material_supplier_api/v1/students/#{student_id}/transfers") do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/students/#{student_id}/transfers")
        [
          200,
          { 'Content-Type': 'application/json' },
          '{"transfer_id": "abcde12345"}',
        ]
      end

      expect(client.create_student_transfer(student_id: student_id, partner_id: partner_id).body).to eq({ "transfer_id" => "abcde12345" }) 
      stubs.verify_stubbed_calls
    end
  end
end
