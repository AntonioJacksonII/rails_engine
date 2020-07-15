require 'rails_helper'

describe Merchant, type: :model do
  it 'exists and has attributes' do
    attributes = {
      name: 'Schroeder-Jerde',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:53:59 UTC'
    }

    merchant = Merchant.new(attributes)

    expect(merchant).to be_a Merchant
    expect(merchant.name).to eq('Schroeder-Jerde')
    expect(merchant.created_at).to eq('2012-03-27 14:53:59 UTC')
    expect(merchant.updated_at).to eq('2012-03-27 14:53:59 UTC')
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
  end
end
