require 'swagger_helper'

RSpec.describe 'api/v1/professors/course_classes', type: :request do

  path '/api/v1/professors/{professor_id}/course_classes' do
    # You'll want to customize the parameter types...
    parameter name: 'professor_id', in: :path, type: :string, description: 'professor_id'

    get('list course_classes') do
      response(200, 'successful') do
        let(:professor_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
