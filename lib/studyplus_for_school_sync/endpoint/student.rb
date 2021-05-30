module StudyplusForSchoolSync
  module Endpoint
    module Student
      def create_passcode(student_id)
        post(path: "#{BASE_PAH}/students/#{student_id}/passcode")
      end

      def inactivate_passcode(student_id)
        delete(path: "#{BASE_PAH}/students/#{student_id}/passcode")
      end

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

      def student_tags(student_id:)
        get(path: "#{BASE_PAH}/students/#{student_id}/tags")
      end

      def attach_student_tag(student_id:, tag_id:)
        put(path: "#{BASE_PAH}/students/#{student_id}/tags/#{tag_id}")
      end

      def detach_student_tag(student_id:, tag_id:)
        delete(path: "#{BASE_PAH}/students/#{student_id}/tags/#{tag_id}")
      end
      
      def student_transfer(student_id:, transfer_id:)
        get(path: "#{BASE_PAH}/students/#{student_id}/transfers/#{transfer_id}")
      end

      def create_student_transfer(student_id:, partner_id:)
        post(path: "#{BASE_PAH}/students/#{student_id}/transfers", params: { partner_id: partner_id })
      end
    end
  end
end
