# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Endpoint /jobs' do
  describe 'GET /jobs' do
    subject { get('/jobs', params: params) and response }
    let(:params) { {} }

    context 'with valid credentials' do
      context 'without search' do
        before do
          params.merge!({ token: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.JC6qKuH9SG0SIiYSfhZUFTtirxN9Q47buLk0DPFFFzE' })
        end
        let!(:job) { create(:job) }
        it 'returns all jobs' do
          expect(subject.status).to eq 200
          expect(JSON.parse(subject.body)).to eq([{ 'final_salary' => 11_200, 'languages' => 'germany',
                                                    'title' => 'programmer' }])
        end
      end

      context 'with title params' do
        before do
          params.merge!({ token: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.JC6qKuH9SG0SIiYSfhZUFTtirxN9Q47buLk0DPFFFzE',
                          title: 'programmer' })
        end
        let!(:job) { create(:job) }
        it 'search by title' do
          expect(subject.status).to eq 200
          expect(JSON.parse(subject.body)).to eq([{ 'final_salary' => 11_200, 'languages' => 'germany',
                                                    'title' => 'programmer' }])
        end
      end

      context 'with language params' do
        before do
          params.merge!({ token: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.JC6qKuH9SG0SIiYSfhZUFTtirxN9Q47buLk0DPFFFzE',
                          languages: 'germany' })
        end
        let!(:job) { create(:job) }
        it 'search by language' do
          expect(subject.status).to eq 200
          expect(JSON.parse(subject.body)).to eq([{ 'final_salary' => 11_200, 'languages' => 'germany',
                                                    'title' => 'programmer' }])
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

  describe 'POST /jobs' do
    subject { post('/jobs', params: params) and response }
    let(:params) { { } }

    context 'with valid credentials' do
      before do
        params.merge!({ token: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.JC6qKuH9SG0SIiYSfhZUFTtirxN9Q47buLk0DPFFFzE' })
      end

      context 'with valid params' do
        let!(:job) { create(:job) }
        before { params.merge!({ title: 'driver', salary: 700, languages: 'germany', shifts: 'friday' }) }
        it 'create new job' do
          expect(subject.status).to eq 200
          expect(JSON.parse(subject.body)).to eq({ 'job' => { 'final_salary' => 5600, 'languages' => 'germany', 'title' => 'driver' },
                                                   'token' => 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.JC6qKuH9SG0SIiYSfhZUFTtirxN9Q47buLk0DPFFFzE' })
        end
      end

      context 'with invalid params' do
        before { params.merge!({ salary: 700, languages: 'germany', shifts: 'friday' }) }
        it 'returns 422 response' do
          expect(subject.status).to eq 422
          expect(JSON.parse(subject.body)).to eq({ 'error' => 'Unprocessable entity',
                                                   'error_messages' => { 'title' => ["can't be blank"] } })
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
