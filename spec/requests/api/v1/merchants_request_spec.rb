require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)
    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(3)
    expect(merchants[:data]).to_not be_empty

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
    expect{Merchant.find(id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  describe :relationships do
    it 'sends a list of items associated with a merchant' do
      create_list(:merchant, 3)
      first_id = Merchant.first.id
      last_id = Merchant.last.id
      create(:item, merchant_id: first_id)
      create(:item, merchant_id: first_id)
      create(:item, merchant_id: first_id)
      first_item = Item.first
      create(:item, merchant_id: last_id)
      last_item = Item.last

      get "/api/v1/merchants/#{first_id}/items"

      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(3)
      expect(items[:data].first[:id]).to eq(first_item.id.to_s)
      expect(items[:data].last[:id]).to_not eq(last_item.id.to_s)

      get "/api/v1/merchants/#{last_id}/items"

      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data].count).to eq(1)
      expect(items[:data].first[:id]).to eq(last_item.id.to_s)
    end
  end

  describe :finders do
    it 'returns a single merchant that matches input criteria' do
      create(:merchant, name: 'Turing')
      create(:merchant, name: 'Fake')
      create(:merchant, name: 'Ring World')

      get '/api/v1/merchants/find?name=ring'

      expect(response).to be_successful
      merchant = JSON.parse(response.body, symbolize_names: true)
      name = merchant[:data][:attributes][:name].downcase

      expect(merchant[:data]).to be_a(Hash)
      expect(name).to include('ring')
    end

    it 'returns all records that match input criteria' do
      create(:merchant, name: 'Turing')
      create(:merchant, name: 'Fake')
      create(:merchant, name: 'Ring World')

      get '/api/v1/merchants/find_all?name=ring'

      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)
      names = merchants[:data].map do |merchant|
        merchant[:attributes][:name].downcase
      end
      expect(names.count).to eq(2)
      names.each{ |name| expect(name).to include('ring')}
    end
  end

  describe :business_intelligence do
    before :each do
      create_list(:merchant, 20)
      merchant1 = Merchant.create!(name: 'First Place')
      merchant2 = Merchant.create!(name: 'Second Place')
      merchant3 = Merchant.create!(name: 'Third Place')
      @id = merchant3.id
      customer1 = Customer.create!(first_name: 'Customer', last_name: 'A')
      customer2 = Customer.create!(first_name: 'Customer', last_name: 'B')
      customer3 = Customer.create!(first_name: 'Customer', last_name: 'C')
      item1 = create(:item, merchant: merchant1, unit_price: 100)
      item2 = create(:item, merchant: merchant2, unit_price: 10)
      item3 = create(:item, merchant: merchant3, unit_price: 1)
      invoice1 = merchant1.invoices.create!(customer: customer1, status: 'shipped')
      invoice2 = merchant2.invoices.create!(customer: customer2, status: 'shipped')
      invoice3 = merchant3.invoices.create!(customer: customer3, status: 'shipped')
      invoice1.invoice_items.create!(item: item1, quantity: 1, unit_price: 100)
      invoice2.invoice_items.create!(item: item2, quantity: 2, unit_price: 10)
      invoice3.invoice_items.create!(item: item3, quantity: 3, unit_price: 1)
      invoice1.transactions.create!(result: 'success')
      invoice2.transactions.create!(result: 'success')
      invoice3.transactions.create!(result: 'success')
    end

    it 'returns a variable list of merchants ranked by total revenue' do
      get '/api/v1/merchants/most_revenue?quantity=2'

      expect(response).to be_successful
      results = JSON.parse(response.body, symbolize_names: true)
      expect(results[:data].length).to eq(2)
      expect(results[:data].first[:attributes][:name]).to eq('First Place')
      expect(results[:data].last[:attributes][:name]).to eq('Second Place')
    end

    it 'returns a variable list of merchants ranked by total items sold' do
      get '/api/v1/merchants/most_items?quantity=3'

      expect(response).to be_successful
      results = JSON.parse(response.body, symbolize_names: true)
      expect(results[:data].length).to eq(3)
      expect(results[:data].first[:attributes][:name]).to eq('Third Place')
      expect(results[:data].last[:attributes][:name]).to eq('First Place')
    end

    it 'returns total revenue for a merchant' do
      get "/api/v1/merchants/#{@id}/revenue"

      expect(response).to be_successful
      results = JSON.parse(response.body, symbolize_names: true)
      expect(results.length).to eq(1)
      expect(results[:data][:id]).to eq(nil)
      expect(results[:data][:attributes][:revenue]).to eq(3)
    end
  end
end
