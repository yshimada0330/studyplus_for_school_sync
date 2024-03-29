require "studyplus_for_school_sync/version"

require "studyplus_for_school_sync/endpoint"
require "studyplus_for_school_sync/client"
require "studyplus_for_school_sync/server"
require "studyplus_for_school_sync/authorizer"
require "studyplus_for_school_sync/token"
require "studyplus_for_school_sync/cli"

module StudyplusForSchoolSync
  class Error < StandardError; end
end
