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
  # CSV.foreach('./db/data/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
  #   InvoiceItem.create!(item_id: row[:item_id],
  #                       invoice_id: row[:invoice_id],
  #                       unit_price: row[:quantity] / 100,
  #                       created_at: row[:created_at],
  #                       updated_at: row[:updated_at])
  # end
end
