RSpec.describe StudyplusForSchoolSync::Server do
  subject { described_class.new.start }
  let(:server) { spy(WEBrick::HTTPServer) }
  before { allow(WEBrick::HTTPServer).to receive(:new).and_return(server) }

  it do
    expect(server).to receive(:start).once
    subject
  end
end
 