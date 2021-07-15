module StudyplusForSchoolSync
  module Endpoint
    module Student
      # Creae passcode
      # @param student_id [String]
      # @return [Hash] API response
      def create_passcode(student_id)
        post(path: "#{BASE_PAH}/students/#{student_id}/passcode")
      end

      # Stop passcode
      # @param student_id [String]
      # @return [Hash] API response
      def inactivate_passcode(student_id)
        delete(path: "#{BASE_PAH}/students/#{student_id}/passcode")
      end

      # Create study record
      # @param learning_material_public_id [String]
      # @param student_public_id [String]
      # @param recorded_at [String]
      # @param [Hash] options
      # @option options [Integer] :amount
      # @option options [Integer] :number_of_seconds
      # @option options [Integer] :start_position
      # @option options [Integer] :end_position
      # @option options [String] :comment
      # @option options [String] :external_link
      # @option options [String] :learning_material_customer_uid
      # @option options [String] :student_customer_uid
      # @return [Hash] API response
      def create_study_record(learning_material_public_id:, student_public_id:, recorded_at:, **options)
        post(
          path: "#{BASE_PAH}/study_records",
          params: options.merge(
            learning_material_public_id: learning_material_public_id,
            student_public_id: student_public_id,
            recorded_at: recorded_at
          )
        )
      end

      # Get student tags
      # @param student_id [String]
      # @return [Hash] API response
      def student_tags(student_id:)
        get(path: "#{BASE_PAH}/students/#{student_id}/tags")
      end

      # Attach student tag
      # @param student_id [String]
      # @param tag_id [String]
      # @return [Hash] API response
      def attach_student_tag(student_id:, tag_id:)
        put(path: "#{BASE_PAH}/students/#{student_id}/tags/#{tag_id}")
      end

      # Detach student tag
      # @param student_id [String]
      # @param tag_id [String]
      # @return [Hash] API response
      def detach_student_tag(student_id:, tag_id:)
        delete(path: "#{BASE_PAH}/students/#{student_id}/tags/#{tag_id}")
      end
      
      # Ge transfer student
      # @param student_id [String]
      # @param transfer_id [String]
      # @return [Hash] API response
      def student_transfer(student_id:, transfer_id:)
        get(path: "#{BASE_PAH}/students/#{student_id}/transfers/#{transfer_id}")
      end

      # Create transfer student
      # @param student_id [String]
      # @param partner_id [String]
      # @return [Hash] API response
      def create_student_transfer(student_id:, partner_id:)
        post(path: "#{BASE_PAH}/students/#{student_id}/transfers", params: { partner_id: partner_id })
      end
    end
  end
end
