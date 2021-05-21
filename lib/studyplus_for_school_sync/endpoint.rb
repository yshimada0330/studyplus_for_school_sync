require_relative "endpoint/learning_material_supplier"
require_relative "endpoint/tag"

module StudyplusForSchoolSync
  module Endpoint
    include LearningMaterialSupplier
    include Tag
  end
end