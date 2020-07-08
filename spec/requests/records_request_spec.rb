require 'rails_helper'

RSpec.describe "Record", type: :request do
  context 'create' do
    it 'should not create a record before sign in' do
      post '/records', params: {amount: 10000, category: 'outgoings', notes: '请客'}
      expect(response.status).to eq 401
    end
    it 'should create a record' do
      sign_in
      post '/records', params: {amount: 10000, category: 'outgoings', notes: '请客'}
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body["resource"]['id']).to be
    end
    it 'should not create a record' do
      sign_in
      post '/records', params: {category: 'outgoings', notes: '请客'}
      expect(response.status).to eq 422
      body = JSON.parse(response.body)
      expect(body["errors"]['amount'][0]).to eq '金额不能为空'
    end
  end

  context 'destroy' do
    it 'should not destroy a record before sign in' do
      record = Record.create! amount: 10000, category: 'income'
      delete "/records/#{record.id}"
      expect(response.status).to eq 401
    end
    it 'should destroy a record' do
      sign_in
      record = Record.create! amount: 10000, category: 'income'
      delete "/records/#{record.id}"
      expect(response.status).to eq 200
    end
  end
end
