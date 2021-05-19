require "webrick"
require "webrick/https"
require "erb"

module StudyplusForSchoolSync
  class Server
    def start(port: "8080")
      root = File.expand_path("../html/index.erb", __FILE__)

      server = WEBrick::HTTPServer.new(
        Port: port,
        DocumentRoot: ".",
        SSLEnable: true,
        SSLCertName: [["CN", WEBrick::Utils.getservername]],
      )

      WEBrick::HTTPServlet::FileHandler.add_handler("erb", WEBrick::HTTPServlet::ERBHandler)
      server.config[:MimeTypes]["erb"] = "text/html"
      server.mount_proc("/") { |req, res|
        code = req.query["code"]
        template = ERB.new(File.read(root))
        res.body << template.result(binding)
      }
      trap "INT" do server.shutdown end
      server.start
    end
  end
end
