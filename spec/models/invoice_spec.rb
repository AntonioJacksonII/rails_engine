require 'rails_helper'

describe Invoice, type: :model do
  it 'exists and has attributes' do
    attributes = {
      customer_id: 1,
      merchant_id: 26,
      status: 'shipped',
      created_at: '2012-03-25 09:54:09 UTC',
      updated_at: '2012-03-25 09:54:09 UTC'
    }

    invoice = Invoice.new(attributes)

    expect(invoice).to be_a Invoice
    expect(invoice.customer_id).to eq(1)
    expect(invoice.merchant_id).to eq(26)
    expect(invoice.status).to eq('shipped')
    expect(invoice.created_at).to eq('2012-03-25 09:54:09 UTC')
    expect(invoice.updated_at).to eq('2012-03-25 09:54:09 UTC')
  end

  describe 'relationships' do
    it {should belong_to :customer}
    it {should belong_to :merchant}
  end
end
