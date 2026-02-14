require "swagger_helper"

RSpec.describe "api/v1/students", type: :request do
  path "/api/v1/students" do
    get("Listar Alunos") do
      tags "Students"
      security [ Bearer: [] ]
      produces "application/json"

      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :per_page, in: :query, type: :integer, required: false

      response(200, "successful") do
        let(:page) { 1 }
        let(:per_page) { 10 }

        let(:Authorization) { "Bearer " + JWT.encode({ user_id: User.create!(name: "Admin", phone: "1", user_type: "student", uuid: SecureRandom.uuid).id }, Rails.application.secret_key_base) }

        run_test!
      end
    end

    post("Criar Aluno") do
      tags "Students"
      security [ Bearer: [] ]
      consumes "application/json"

      parameter name: :student, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          phone: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: [ "name", "phone", "email" ]
      }

      response(201, "created") do
        let(:Authorization) { "Bearer " + JWT.encode({ user_id: User.create!(name: "Admin", phone: "1", user_type: "student", uuid: SecureRandom.uuid).id }, Rails.application.secret_key_base) }
        let(:student) { { name: "New Student", phone: "999", email: "new@test.com", password: "123" } }
        run_test!
      end
    end
  end
end
