require 'swagger_helper'

RSpec.describe 'api/v1/posts', type: :request do
  # spec/requests/user_registration_spec.rb
  #
  path '/api/v1/users/{user_id}/posts' do
    # You'll want to customize the parameter types...
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

    let(:user) { FactoryBot.create(:user) } # Create a user using FactoryBot

    before do
      user.confirm
      user.save
      sign_in user # Sign in the user using Devise
    end

    let(:post) { Post.create(author: user, text: 'user foo first post', title: 'user foo first post title') }
    get('list posts') do
      response(200, 'successful') do
        let(:user_id) { user.id }
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
