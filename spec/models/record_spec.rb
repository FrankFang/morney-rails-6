require 'rails_helper'

RSpec.describe Record, type: :model do
  it 'amount is required' do
    record = Record.create notes: 'xx', category: 'outgoings'
    expect(record.errors.details[:amount][0][:error]).to eq(:blank)
  end
  it 'category is required' do
    record = Record.create notes: 'xx', amount: 10000
    expect(record.errors.details[:category][0][:error]).to eq(:blank)
  end
  it 'category 只能是 outgoings 或者 income' do
    expect {
      Record.create amount: 10000, notes: 'xx', category: 'outgoing'
    }.to raise_error(ArgumentError)
  end
end
