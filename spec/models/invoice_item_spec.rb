require 'rails_helper'

describe InvoiceItem, type: :model do
  it 'exists and has attributes' do
    attributes = {
      item_id: 539,
      invoice_id: 1,
      quantity: 5,
      unit_price: 13635,
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
    }

    invoice_item = InvoiceItem.new(attributes)

    expect(invoice_item).to be_a InvoiceItem
    expect(invoice_item.item_id).to eq(539)
    expect(invoice_item.invoice_id).to eq(1)
    expect(invoice_item.quantity).to eq(5)
    expect(invoice_item.unit_price).to eq(13635)
    expect(invoice_item.created_at).to eq('2012-03-27 14:54:09 UTC')
    expect(invoice_item.updated_at).to eq('2012-03-27 14:54:09 UTC')
  end

  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end
end
