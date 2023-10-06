require 'swagger_helper'

RSpec.describe 'api/v1/posts', type: :request do
  path '/api/v1/users/{user_id}/posts' do
    # You'll want to customize the parameter types...
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'
    #    before do
    #   @user = User.create(name: 'foo', email: 'user10@test.com', role: 'bar', posts_counter: 0)
    # end

    get('list posts') do
      response(200, 'successful') do
        let(:user_id) { '362' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      # response(404,'Not found' ) do
      #   let(:user_id) { '30' }
      #   run_test!
      # end
    end
  end
end
