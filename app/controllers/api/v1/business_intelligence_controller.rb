class Api::V1::BusinessIntelligenceController < ApplicationController
  def index
    quantity = params[:quantity].to_i
    if request.path == '/api/v1/merchants/most_revenue'
      data = Merchant.joins(invoices:[:invoice_items, :transactions]).where("transactions.result='success'").group("merchants.id").select("merchants.id, merchants.name, sum(invoice_items.quantity*invoice_items.unit_price) as revenue").order("revenue desc").limit(quantity)
      render json: MerchantSerializer.new(data)
    elsif request.path == '/api/v1/merchants/most_items'
      data = data = Merchant.joins(invoices:[:invoice_items, :transactions]).where("transactions.result='success'").group("merchants.id").select("merchants.id, merchants.name, sum(invoice_items.quantity) as total_sold").order("total_sold desc").limit(quantity)
      render json: MerchantSerializer.new(data)
    end
  end
end
