require "thor"

module StudyplusForSchoolSync
  class Cli < Thor
    desc "server", "Start the server for redirection. ex) server --port 8080"
    option :port
    def server
      params = {}
      params[:port] = options[:port] if options[:port]
      StudyplusForSchoolSync::Server.new.start(**params)
    end

    desc "authorize REDIRECT_URI", "Retrieve Authorization Code. ex) authorize https://localhost:8080"
    def authorize(redirect_uri)
      StudyplusForSchoolSync::Authorizer.new(client_id: ENV["CLIENT_ID"], redirect_uri: redirect_uri).authorize
    end
  end
end
