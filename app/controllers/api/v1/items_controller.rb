class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    id = params[:id]
    render json: ItemSerializer.new(Item.find(id))
  end
end
