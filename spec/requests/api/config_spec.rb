require 'swagger_helper'

describe 'Navigation API', type: :request do
  include ApiHelper

  path '/config' do
    get 'configuration variables' do
      tags 'General'
      produces 'application/json'
      let(:api_scopes) { ['config:user'] }

      response '200', 'success' do
        run_test!
      end

      it_handles_invalid_token_and_scope
    end
  end
end
