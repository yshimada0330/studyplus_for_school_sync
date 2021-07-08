require "thor"

module StudyplusForSchoolSync
  # Command Line Tool
  class Cli < Thor
    DEFAULT_REDIRECT_URI = "https://localhost:8080"

    desc "server", "Start the server for redirection. ex) server --port 8080"
    option :port
    def server
      params = {}
      params[:port] = options[:port] if options[:port]
      StudyplusForSchoolSync::Server.new.start(**params)
    end

    desc "authorize [BASE_URL] [CLIENT_ID]", "Retrieve Authorization Code. ex) authorize https://xxxx.studyplus.co.jp xxxxxxxx"
    option :redirect_uri
    option :scopes, desc: "Specify scopes separated by commas"
    def authorize(base_url, client_id)
      params = { client_id: client_id, base_url: base_url, redirect_uri: DEFAULT_REDIRECT_URI }
      params[:redirect_uri] = options[:redirect_uri] if options[:redirect_uri]
      params[:scopes] = options[:scopes].split(",") if options[:scopes]
      StudyplusForSchoolSync::Authorizer.new(**params).authorize
    end
  end
end
