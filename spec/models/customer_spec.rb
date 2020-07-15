require 'rails_helper'

describe Customer, type: :model do
  it 'exists and has attributes' do
    attributes = {
      first_name: 'Joey',
      last_name: 'Ondricka',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
    }

    customer = Customer.new(attributes)

    expect(customer).to be_a Customer
    expect(customer.first_name).to eq('Joey')
    expect(customer.last_name).to eq('Ondricka')
    expect(customer.created_at).to eq('2012-03-27 14:54:09 UTC')
    expect(customer.updated_at).to eq('2012-03-27 14:54:09 UTC')
  end

  describe 'relationships' do
    it {should have_many :invoices}
  end
end
