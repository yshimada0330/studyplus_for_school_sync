RSpec.describe StudyplusForSchoolSync::Cli do
  describe "#server" do
    subject { described_class.start(%w[server --port 3000])}

    let(:server) { instance_double(StudyplusForSchoolSync::Server) }
    let(:params) { { port: "3000" } }

    before do
      allow(StudyplusForSchoolSync::Server).to receive(:new).and_return(server)
    end

    it do
      expect(server).to receive(:start).with(params).once
      subject
    end
  end

  describe "#authorize" do
    subject { described_class.start(%w[authorize https://example.com xxxxxxxx --redirect_uri http://localhost --scopes a,b])}

    let(:authorizer) { instance_double(StudyplusForSchoolSync::Authorizer) }
    let(:params) do
      {
        base_url: "https://example.com",
        client_id: "xxxxxxxx",
        redirect_uri: "http://localhost",
        scopes: ["a", "b"],
      }
    end

    it do
      expect(StudyplusForSchoolSync::Authorizer).to receive(:new).with(**params).and_return(authorizer)
      expect(authorizer).to receive(:authorize).once
      subject
    end
  end
end
 