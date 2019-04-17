require 'rails_helper'

RSpec.describe 'todos API', type: :request do

  # initialize test data
  let!(:todos) { create_list(:todo, 3) }
  let(:todo_id) { todos.first.id }

  # Test suite for GET /articles
  describe 'GET /todos' do
    # make HTTP get request before each example
    before { get '/api/v1/todos' }

    it 'returns todos' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /api/v1/todos
  describe 'POST /api/v1/todos' do
    # valid payload
    let(:valid_attributes) { { todo: {title: 'take a loan, quit work, Go to the village', done: false} } }

    context 'when the request is valid' do
      before { post '/api/v1/todos', params: valid_attributes }

      it 'creates a todos' do
        expect(json['title']).to eq('take a loan, quit work, Go to the village')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/todos', params: { todo: {title: ''} } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"title\":[\"can't be blank\"]}")
      end
    end
  end

  # Test suite for PUT /api/v1/todos
  describe 'PUT /api/v1/todos/:id' do
    let(:valid_attributes) { { todo: { done: true }} }

    context 'when the record exists' do
      before { put "/api/v1/todos/#{todo_id}", params: valid_attributes }

      it 'updates the record' do
        expect(json['done']).to eq(true)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE /api/v1/todos
  describe 'DELETE /api/v1/todos/:id' do
    before { delete "/api/v1/todos/#{todo_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
