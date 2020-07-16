require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    create :merchant
    merchant = Merchant.last
    3.times do
      create(:item, merchant: merchant)
    end
    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(3)
    expect(items[:data]).to_not be_empty
  end
end
