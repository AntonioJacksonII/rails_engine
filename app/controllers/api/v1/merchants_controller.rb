class Api::V1::MerchantsController < ApplicationController
  def index
    if merchant_params.keys.count > 0
      merchants = Merchant.where("name ilike ?", "%#{merchant_params[:name]}%")
      render json: MerchantSerializer.new(merchants)
    else
      render json: MerchantSerializer.new(Merchant.all)
    end
  end

  def show
    id = params[:id]
    if id
      render json: MerchantSerializer.new(Merchant.find(id))
    else
      merchant = Merchant.where("name ilike ?", "%#{merchant_params[:name]}%").first
      render json: MerchantSerializer.new(merchant)
    end
  end

  def create
    render json: MerchantSerializer.new(Merchant.create(merchant_params))
  end

  def update
    id = params[:id]
    render json: MerchantSerializer.new(Merchant.update(id, merchant_params))
  end

  def destroy
    id = params[:id]
    render json: MerchantSerializer.new(Merchant.find(id))
    Merchant.delete(id)
  end

  private

    def merchant_params
      params.permit(:name, :created_at, :updated_at, :id)
    end
end
