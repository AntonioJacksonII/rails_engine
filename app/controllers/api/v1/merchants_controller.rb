class Api::V1::MerchantsController < ApplicationController
  def index
      render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    id = params[:id]
    render json: MerchantSerializer.new(Merchant.find(id))
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
      params.permit(:name)
    end
end
