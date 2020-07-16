class Api::V1::BusinessIntelligenceController < ApplicationController
  def index
    quantity = params[:quantity].to_i
    id = params[:id].to_i
    if request.path == '/api/v1/merchants/most_revenue'
      data = Merchant.joins(invoices:[:invoice_items, :transactions]).where("transactions.result='success'").group("merchants.id").select("merchants.id, merchants.name, sum(invoice_items.quantity*invoice_items.unit_price) as revenue").order("revenue desc").limit(quantity)
      render json: MerchantSerializer.new(data)
    elsif request.path == '/api/v1/merchants/most_items'
      data = Merchant.joins(invoices:[:invoice_items, :transactions]).where("transactions.result='success'").group("merchants.id").select("merchants.id, merchants.name, sum(invoice_items.quantity) as total_sold").order("total_sold desc").limit(quantity)
      render json: MerchantSerializer.new(data)
    elsif request.path == "/api/v1/merchants/#{id}/revenue"
      data = Merchant.joins(invoices:[:invoice_items, :transactions]).where("transactions.result='success'").group("merchants.id").select("sum(invoice_items.quantity*invoice_items.unit_price) as revenue").order("revenue desc").where("merchants.id=#{id}")
      render json: {"data"=> {"id"=> nil,"attributes"=> {"revenue"=> data.first[:revenue]}}}
    end
  end
end
