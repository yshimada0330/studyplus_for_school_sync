module StudyplusForSchoolSync
  module Endpoint
    module LearningMaterialSupplier
      BASE_PAH = "learning_material_supplier_api/v1"

      def create_learning_material(name:, **options)
        post(path: "#{BASE_PAH}/learning_materials", params: options.merge(name: name))
      end


      def update_learning_material(learning_material_public_id:, name:, **options)
        put(path: "#{BASE_PAH}/learning_materials/#{learning_material_public_id}", params: options.merge(name: name))
      end
    end
  end
end