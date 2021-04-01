# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Endpoint /users' do
  describe 'POST /users' do
    subject { post('/users', params: params) and response }
    let(:params) { {} }

    context 'new user' do
      before { params.merge!({ email: 'User1', password: '123' }) }

      it 'creates a new user' do
        expect(subject.status).to eq 200
        expect(JSON.parse(subject.body)).to eq({ 'email' => 'User1' })
      end
    end

    context 'existing user' do
      let!(:user) { create(:user) }
      let(:response_body) do
        '{"error":"Unprocessable entity","error_messages":{"email":["has already been taken"]}}'
      end

      before { params.merge!({ email: user.email, password: '123' }) }

      it 'returns 422' do
        expect(subject.status).to eq 422
        expect(subject.body).to eq response_body
      end
    end

    context 'without password' do
      before { params.merge!({ email: 'user.email' }) }

      it 'returns 422 response' do
        expect(subject.status).to eq 422
        expect(subject.body).to(
          eq "{\"error\":\"Unprocessable entity\",\"error_messages\":{\"password\":[\"can't be blank\"]}}"
        )
      end
    end
  end

  describe 'POST /users/login' do
    subject { post('/users/login', params: params) and response }
    let(:params) { {} }

    context 'with valid password' do
      let!(:user) { create(:user) }
      let(:response_json) do
        { 'token' => 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.JC6qKuH9SG0SIiYSfhZUFTtirxN9Q47buLk0DPFFFzE',
          'user' => { 'email' => '111111' } }
      end

      before { params.merge!({ email: user.email, password: '111111' }) }

      it 'logs in user' do
        expect(subject.status).to eq 200
        expect(JSON.parse(subject.body)).to eq response_json
      end
    end

    context 'with invalid password' do
      let!(:user) { create(:user) }
      before { params.merge!({ email: user.email, password: '1234' }) }

      it 'return 401 response' do
        expect(subject.status).to eq 401
        expect(subject.body).to eq '{"error":"Unauthorized"}'
      end
    end
  end
end
