require "studyplus_for_school_sync/version"

require "faraday"

require "studyplus_for_school_sync/endpoint"
require "studyplus_for_school_sync/client"
require "studyplus_for_school_sync/server"
require "studyplus_for_school_sync/authorizer"

module StudyplusForSchoolSync
  class Error < StandardError; end
end
