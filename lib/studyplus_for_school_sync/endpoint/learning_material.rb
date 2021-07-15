module StudyplusForSchoolSync
  module Endpoint
    module LearningMaterial
      # Creae learning material
      # @param name[String] learning material name
      # @param [Hash]options
      # @option options [String] :image_url
      # @option options [String] :unit
      # @option options [String] :customer_id
      # @return [Hash] API response
      def create_learning_material(name:, **options)
        post(path: "#{BASE_PAH}/learning_materials", params: options.merge(name: name))
      end

      # Update learning material
      # @param name[String] learning material name
      # @param [Hash] options
      # @option options [String] :image_url
      # @option options [String] :unit
      # @option options [String] :customer_id
      # @return [Hash] API response
      def update_learning_material(learning_material_public_id:, name:, **options)
        put(path: "#{BASE_PAH}/learning_materials/#{learning_material_public_id}", params: options.merge(name: name))
      end
    end
  end
end
