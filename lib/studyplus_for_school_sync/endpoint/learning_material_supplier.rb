module StudyplusForSchoolSync
  module Endpoint
    module LearningMaterialSupplier
      BASE_PAH = "learning_material_supplier_api/v1"

      def create_learning_material(access_token:, name:, **options)
        post(access_token: access_token, path: "#{BASE_PAH}/learning_materials", params: options.merge(name: name))
      end
    end
  end
end