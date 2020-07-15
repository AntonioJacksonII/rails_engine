class Api::V1::ItemsController < ApplicationController
  def index
    merchant_id = params[:merchant_id]
    render json: ItemSerializer.new(Item.where("merchant_id=#{merchant_id}"))
  end
end
