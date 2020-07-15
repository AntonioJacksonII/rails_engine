require 'rails_helper'

describe Item, type: :model do
  it 'exists and has attributes' do
    attributes = {
      name: 'Item Qui Esse',
      description: 'Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.',
      merchant_id: '75107',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:53:59 UTC'
    }

    item = Item.new(attributes)

    expect(item).to be_an Item
    expect(item.name).to eq('Item Qui Esse')
    expect(item.description).to eq('Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.')
    expect(item.merchant_id).to eq(75107)
    expect(item.created_at).to eq('2012-03-27 14:53:59 UTC')
    expect(item.updated_at).to eq('2012-03-27 14:53:59 UTC')
  end

  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end
end
