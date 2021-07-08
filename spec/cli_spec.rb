RSpec.describe StudyplusForSchoolSync::Cli do
  describe "#authorize" do
    subject { described_class.start(%w[authorize https://example.com xxxxxxxx --redirect_uri http://localhost])}

    let(:authorizer) { instance_double(StudyplusForSchoolSync::Authorizer) }
    let(:params) do
      {
        base_url: "https://example.com",
        client_id: "xxxxxxxx",
        redirect_uri: "http://localhost",
      }
    end

    it do
      expect(StudyplusForSchoolSync::Authorizer).to receive(:new).with(**params).and_return(authorizer)
      expect(authorizer).to receive(:authorize).once
      subject
    end
  end
end
 