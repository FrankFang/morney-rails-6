require 'rails_helper'

RSpec.describe "Taggings", type: :request do
  before :each do
    @record = Record.create! amount: 10000, category: 'income'
    @tag = Tag.create! name: 'test'
    @tagging = Tagging.create tag: @tag, record: @record
    (1..10).to_a.map do |n|
      Tagging.create! record: @record, tag: Tag.create!(name: "test#{n}")
    end
  end
  context 'create' do
    it 'should not create a tagging before sign in' do
      post '/taggings'
      expect(response.status).to eq 401
    end
    it 'should create a tagging after sign in' do
      sign_in
      post '/taggings', params: {record_id: @record.id, tag_id: @tag.id}
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body['resource']['id']).to be
    end
    it 'should not create a tagging without record_id' do
      sign_in
      post '/taggings', params: {tag_id: @tag.id}
      expect(response.status).to eq 422
      body = JSON.parse(response.body)
      expect(body['errors']['record'][0]).to eq '记录不能为空'
    end
  end
  context 'destroy' do
    it 'should not destroy a tagging before sign in' do
      delete "/taggings/#{@tagging.id}"
      expect(response.status).to eq 401
    end
    it 'should destroy a tagging after sign in' do
      sign_in
      delete "/taggings/#{@tagging.id}"
      expect(response.status).to eq 200
    end
  end

  context 'index' do
    it 'should not get taggings before sign in' do
      get '/taggings'
      expect(response.status).to eq 401
    end
    it 'should get taggings' do
      sign_in
      get '/tags'
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resources'].length).to eq 10
    end
  end

  context 'show' do
    it 'should not get a tagging before sign in' do
      get "/taggings/#{@tagging.id}"
      expect(response.status).to eq 401
    end
    it 'should get a record' do
      sign_in
      get "/taggings/#{@tagging.id}"
      expect(response.status).to eq 200
    end
    it 'should not get a record because not found' do
      sign_in
      get "/taggings/99999999"
      expect(response.status).to eq 404
    end
  end
end
