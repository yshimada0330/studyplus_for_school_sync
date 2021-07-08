RSpec.describe StudyplusForSchoolSync::Authorizer do
  describe "#authorize" do
    subject { described_class.new(**params).authorize }
    let(:base_url) { "http://example.com" }
    let(:client_id) { "XXXXX" }
    let(:redirect_uri) { "http://localhost" }
    let(:params) do
      {
        base_url: base_url,
        client_id: client_id,
        redirect_uri: redirect_uri,
      }
    end
    let(:url) do
      "#{base_url}/#{StudyplusForSchoolSync::Authorizer::END_POINT}?client_id=#{client_id}&response_type=code&redirect_uri=http%3A%2F%2Flocalhost&scope=learning_material_supplier+lms_passcode_issue"
    end

    it do
      expect(Launchy).to receive(:open).with(url)
      subject
    end
  end
end
 