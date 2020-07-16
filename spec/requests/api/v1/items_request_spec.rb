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

  it 'can get one item by its id' do
    create :merchant
    merchant = Merchant.last
    id = create(:item, merchant: merchant).id
    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(item[:data][:id]).to eq(id.to_s)
  end
end
