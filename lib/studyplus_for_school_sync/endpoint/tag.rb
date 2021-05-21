module StudyplusForSchoolSync
  module Endpoint
    module Tag
      BASE_PAH = "learning_material_supplier_api/v1"

      def tags(partner_id:, page: 1)
        get(path: "#{BASE_PAH}/partners/#{partner_id}/tags", params: { page: page })
      end

      def create_tag(partner_id:, name:, **options)
        post(path: "#{BASE_PAH}/partners/#{partner_id}/tags", params: options.merge(name: name))
      end

      def update_tag(partner_id:, tag_id:, name:, **options)
        patch(path: "#{BASE_PAH}/partners/#{partner_id}/tags/#{tag_id}", params: options.merge(name: name))
      end

      def delete_tag(partner_id:, tag_id:)
        delete(path: "#{BASE_PAH}/partners/#{partner_id}/tags/#{tag_id}")
      end
    end
  end
end
