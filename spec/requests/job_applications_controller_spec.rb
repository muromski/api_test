# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Endpoint /job_applications' do
  describe 'POST /job_applications' do
    subject { post('/job_applications', params: params) and response }
    let(:params) { {} }

    context 'with valid credentials' do
      before do
        params.merge!({ token: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.JC6qKuH9SG0SIiYSfhZUFTtirxN9Q47buLk0DPFFFzE' })
      end

      context 'with valid params' do
        before { params.merge!({ job_id: 1 }) }
        it 'create new response' do
          expect(subject.status).to eq 200
          expect(JSON.parse(subject.body)).to eq({ 'job_id' => 1, 'user_id' => 1 })
        end
      end

      context 'with invalid params' do
        it 'returns 422 response' do
          expect(subject.status).to eq 422
          expect(JSON.parse(subject.body)).to eq({ 'error' => 'Unprocessable entity',
                                                   'error_messages' => { 'job_id' => ["can't be blank"] } })
        end
      end
    end

    context 'with invalid credentials' do
      it 'returns unauthorized response' do
        expect(subject.status).to eq 401
        expect(JSON.parse(subject.body)).to eq({ 'error' => 'Unauthorized' })
      end
    end
  end
end
