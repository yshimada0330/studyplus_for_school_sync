require "faraday"
require "faraday_middleware"
require "json"

RSpec.describe StudyplusForSchoolSync::Token do
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:conn) do
    Faraday.new do |connection|
      connection.response :json
      connection.adapter(:test, stubs)
    end
  end
  let(:base_url) { "http://example.com" }
  let(:client_id) { "sample_id" }
  let(:client_secret) { "sample_pass" }
  let(:token) { described_class.new(base_url: base_url, client_id: client_id, client_secret: client_secret) }

  before do
    allow(Faraday).to receive(:new).and_return(conn)
  end

  context "#create" do
    let(:authorization_code) { "sample_code" }
    let(:redirect_uri) { "https://localhost" }
    let(:params) do
      {
        client_id: client_id,
        client_secret: client_secret,
        redirect_uri: redirect_uri,
        grant_type: "authorization_code",
        code: authorization_code,
      }
    end
    let(:response_body) do
      {
        "access_token" => "sample_token",
        "token_type" => "Bearer",
        "expires_in" => 86399,
        "refresh_token" => "sample_refresh_token",
        "scope" => "learning_material_supplier lms_passcode_issue",
        "created_at" => 1621558627,
      }
    end

    it "status=200" do
      stubs.post("#{base_url}/learning_material_supplier_api/v1/oauth/token", params.to_json) do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/oauth/token")
        [
          200,
          { 'Content-Type': 'application/json' },
          '{
            "access_token": "sample_token",
            "token_type": "Bearer",
            "expires_in": 86399,
            "refresh_token": "sample_refresh_token",
            "scope": "learning_material_supplier lms_passcode_issue",
            "created_at": 1621558627
          }',
        ]
      end

      expect(token.create(authorization_code: authorization_code, redirect_uri: redirect_uri).body).to eq(response_body)
      stubs.verify_stubbed_calls
    end
  end
  
  context "#refresh" do
    let(:refresh_token) { "sample_token" }
    let(:params) do
      {
        client_id: client_id,
        client_secret: client_secret,
        grant_type: "refresh_token",
        refresh_token: refresh_token,
      }
    end
    let(:response_body) do
      {
        "access_token" => "sample_token",
        "token_type" => "Bearer",
        "expires_in" => 86399,
        "refresh_token" => "sample_refresh_token",
        "scope" => "learning_material_supplier lms_passcode_issue",
        "created_at" => 1621558627,
      }
    end

    it "status=200" do
      stubs.post("#{base_url}/learning_material_supplier_api/v1/oauth/token", params.to_json) do |env|
        expect(env.url.path).to eq("/learning_material_supplier_api/v1/oauth/token")
        [
          200,
          { 'Content-Type': 'application/json' },
          '{
            "access_token": "sample_token",
            "token_type": "Bearer",
            "expires_in": 86399,
            "refresh_token": "sample_refresh_token",
            "scope": "learning_material_supplier lms_passcode_issue",
            "created_at": 1621558627
          }',
        ]
      end

      expect(token.refresh(refresh_token).body).to eq(response_body)
      stubs.verify_stubbed_calls
    end
  end
end
