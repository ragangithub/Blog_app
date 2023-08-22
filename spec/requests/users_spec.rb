require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET index' do
    it 'returns a successful response' do
      get users_path
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('Here is a list of users')
    end
  end

describe 'GET #show_user' do
    it 'renders the show_user template' do
      get '/users/1'
      expect(response).to render_template('users/show')
    end

    it 'returns a 200 OK status' do
      get '/users/1'
      expect(response).to have_http_status(:ok)
    end

    it 'includes the correct placeholder text in the response body' do
      get '/users/1'
      expect(response.body).to include('Here is detail of a given user')
    end
  end
end
