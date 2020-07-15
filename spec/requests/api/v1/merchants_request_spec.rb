require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)
    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(3)
  end

  it 'can get one merchant by its id' do
    id = create(:merchant).id
    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(merchant[:data][:id]).to eq(id.to_s)
  end

  it 'can create a new merchant' do
    post '/api/v1/merchants', params: {name: 'Test Merchant'}
    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq('Test Merchant')
  end

  it 'can update a merchant' do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    patch "/api/v1/merchants/#{id}", params: { name: 'New Merchant Name' }

    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq('New Merchant Name')
  end

  it 'can destroy a merchant' do
    id = create(:merchant).id
    delete "/api/v1/merchants/#{id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Item.find(id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
