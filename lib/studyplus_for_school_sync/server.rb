require "webrick"

module StudyplusForSchoolSync
  class Server
    def start
      root = File.expand_path("../html/index.html", __FILE__)

      server = WEBrick::HTTPServer.new Port: 8080, DocumentRoot: root
      trap "INT" do server.shutdown end

      server.start
    end
  end
end
