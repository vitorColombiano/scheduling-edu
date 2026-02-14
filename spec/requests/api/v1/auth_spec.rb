require "swagger_helper"

RSpec.describe "api/v1/auth", type: :request do
  path "/api/v1/auth/login" do
    post("Fazer Login") do
      tags "Auth"
      consumes "application/json"

      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: "student@test.com" },
          password: { type: :string, example: "123456" }
        },
        required: [ "email", "password" ]
      }

      response(200, "successful") do
        let(:credentials) { { email: "student@test.com", password: "123456" } }

        before do
          user = User.create!(name: "Student", phone: "123", user_type: "student", uuid: SecureRandom.uuid)
          Login.create!(email: "student@test.com", password_hash: BCrypt::Password.create("123456"), user: user)
        end

        run_test!
      end

      response(401, "unauthorized") do
        let(:credentials) { { email: "wrong@test.com", password: "wrong" } }
        run_test!
      end
    end
  end
end
