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

  it 'can create a new item' do
    create :merchant
    merchant = Merchant.last
    body = {
          name: 'New Item',
          description: 'description',
          unit_price: 1000,
          merchant_id: merchant.id
        }
    post '/api/v1/items', params: body
    new_item = Item.last

    expect(response).to be_successful
    expect(new_item.name).to eq('New Item')
  end

  it 'can update an item' do
    merchant = create :merchant
    id = create(:item, merchant: merchant).id
    previous_name = Item.last.name
    patch "/api/v1/items/#{id}", params: { name: 'New Item Name' }

    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq('New Item Name')
  end
end
