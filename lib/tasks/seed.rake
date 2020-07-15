require 'fileutils'
require 'csv'

task seed: :environment do
  sh %{ rails db:{drop,create,migrate}}
  CSV.foreach('./db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
    Customer.create!( first_name: row[:first_name],
                      last_name: row[:last_name],
                      created_at: row[:created_at],
                      updated_at: row[:updated_at])
  end
  CSV.foreach('./db/data/merchants.csv', headers: true, header_converters: :symbol) do |row|
    Merchant.create!( name: row[:name],
                      created_at: row[:created_at],
                      updated_at: row[:updated_at])
  end
  CSV.foreach('./db/data/items.csv', headers: true, header_converters: :symbol) do |row|
    Item.create!( name: row[:name],
                  description: row[:description],
                  unit_price: row[:unit_price].to_f / 100,
                  merchant_id: row[:merchant_id],
                  created_at: row[:created_at],
                  updated_at: row[:updated_at])
  end
  CSV.foreach('./db/data/invoices.csv', headers: true, header_converters: :symbol) do |row|
    Invoice.create!(customer_id: row[:customer_id],
                    merchant_id: row[:merchant_id],
                    status: row[:status],
                    created_at: row[:created_at],
                    updated_at: row[:updated_at])
  end
end
