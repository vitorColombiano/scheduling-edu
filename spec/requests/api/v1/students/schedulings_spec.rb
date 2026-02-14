require 'swagger_helper'

RSpec.describe 'api/v1/students/schedulings', type: :request do

  path '/api/v1/students/{student_id}/schedulings' do
    # You'll want to customize the parameter types...
    parameter name: 'student_id', in: :path, type: :string, description: 'student_id'

    get('list schedulings') do
      response(200, 'successful') do
        let(:student_id) { '123' }

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
