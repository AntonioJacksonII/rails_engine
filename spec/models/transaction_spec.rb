require 'rails_helper'

describe Transaction, type: :model do
  it 'exists and has attributes' do
    attributes = {
      invoice_id: 1,
      credit_card_number: '4654405418249632',
      result: 'success',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
    }

    transaction = Transaction.new(attributes)

    expect(transaction).to be_a Transaction
    expect(transaction.invoice_id).to eq(1)
    expect(transaction.credit_card_number).to eq('4654405418249632')
    expect(transaction.credit_card_expiration_date).to eq(nil)
    expect(transaction.result).to eq('success')
    expect(transaction.created_at).to eq('2012-03-27 14:54:09 UTC')
    expect(transaction.updated_at).to eq('2012-03-27 14:54:09 UTC')
  end

  describe 'relationships' do
    it {should belong_to :invoice}
  end
end
