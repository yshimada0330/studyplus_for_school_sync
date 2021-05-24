module StudyplusForSchoolSync
  module Endpoint
    module Partner
      def create_partner(school_name:, **options)
        post(path: "#{BASE_PAH}/partners", params: options.merge(school_name: school_name))
      end

      def create_student(partner_public_id:, last_name:, first_name:, last_name_kana:, first_name_kana:, **options)
        post(
          path: "#{BASE_PAH}/partners/#{partner_public_id}/students",
          params: options.merge(
            last_name: last_name,
            first_name: first_name,
            last_name_kana: last_name_kana,
            first_name_kana: first_name_kana
          )
        )
      end

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
 