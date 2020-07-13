require 'rails_helper'

RSpec.describe Tagging, type: :model do
  context 'create' do
    it 'require record' do
      tag = Tag.create! name:'test'
      tagging = Tagging.create tag: tag
      expect(tagging.errors.details[:record][0][:error]).to eq(:blank)
      expect(tagging.errors[:record][0]).to eq('记录不能为空')
    end
    it 'require tag' do
      record = Record.create amount: 10000, category: 'income'
      tagging = Tagging.create record: record
      expect(tagging.errors.details[:tag][0][:error]).to eq(:blank)
      expect(tagging.errors[:tag][0]).to eq('标签不能为空')
    end
  end
end
