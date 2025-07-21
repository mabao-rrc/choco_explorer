class ProductsController < ApplicationController
  def index
    @products = Product.includes(:brand, :countries).all
  end

  def show
    @product = Product.find(params[:id])
  end
end
