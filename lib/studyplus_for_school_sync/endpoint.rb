require_relative "endpoint/learning_material"
require_relative "endpoint/partner"
require_relative "endpoint/student"

module StudyplusForSchoolSync
  module Endpoint
    BASE_PAH = "learning_material_supplier_api/v1"

    include LearningMaterial
    include Partner
    include Student
  end
end