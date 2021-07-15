module StudyplusForSchoolSync
  module Endpoint
    module Partner
      # Create partner
      # @param partner_name [String]
      # @param [Hash] options
      # @option options [String] :name
      # @option options [String] :timezone
      # @option options [String] :started_on
      # @option options [String] :customer_id
      # @return [Hash] API response
      def create_partner(school_name:, **options)
        post(path: "#{BASE_PAH}/partners", params: options.merge(school_name: school_name))
      end

      # Create student
      # @param partner_public_id [String]
      # @param last_name [String]
      # @param first_name [String]
      # @param last_name_kana [String]
      # @param first_name_kana [String]
      # @param [Hash] options
      # @option options [String] :school_type
      # @option options [String] :grade
      # @option options [String] :code
      # @return [Hash] API response
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

      # Get tags
      # @param parner_id [String]
      # @param page [Integer]
      # @return [Hash] API response
      def tags(partner_id:, page: 1)
        get(path: "#{BASE_PAH}/partners/#{partner_id}/tags", params: { page: page })
      end

      # Creae tag
      # @param partner_id [String]
      # @param name [String]
      # @param [Hash] options
      # @option options [String] :customer_id
      # @return [Hash] API response
      def create_tag(partner_id:, name:, **options)
        post(path: "#{BASE_PAH}/partners/#{partner_id}/tags", params: options.merge(name: name))
      end

      # Update tag
      # @param partner_id [String]
      # @param tag_id [String]
      # @param name [String]
      # @param options [Hash]
      # @param options [String] :customer_id
      # @return [Hash] API response
      def update_tag(partner_id:, tag_id:, name:, **options)
        patch(path: "#{BASE_PAH}/partners/#{partner_id}/tags/#{tag_id}", params: options.merge(name: name))
      end

      # Delete tag
      # @param partner_id [String]
      # @param tag_id [String]
      # @return [Hash] API response
      def delete_tag(partner_id:, tag_id:)
        delete(path: "#{BASE_PAH}/partners/#{partner_id}/tags/#{tag_id}")
      end
    end
  end
end
 