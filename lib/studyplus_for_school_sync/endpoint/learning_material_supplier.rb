module StudyplusForSchoolSync
  module Endpoint
    module LearningMaterialSupplier
      BASE_PAH = "learning_material_supplier_api/v1"

      def create_partner(school_name:, **options)
        post(path: "#{BASE_PAH}/partners", params: options.merge(school_name: school_name))
      end

      def create_learning_material(name:, **options)
        post(path: "#{BASE_PAH}/learning_materials", params: options.merge(name: name))
      end

      def update_learning_material(learning_material_public_id:, name:, **options)
        put(path: "#{BASE_PAH}/learning_materials/#{learning_material_public_id}", params: options.merge(name: name))
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

      def create_passcode(student_public_id)
        post(path: "#{BASE_PAH}/students/#{student_public_id}/passcode")
      end

      # TODO: json parse error with no content for http 200
      #       https://github.com/nahi/httpclient/blob/master/lib/jsonclient.rb#L57
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
    end
  end
end