# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  def index
    @products = Product.includes(:brand, :categories)

    # Filter by category first
    if params[:category].present? && params[:category] != "all"
      @products = @products.joins(:categories).where(categories: { name: params[:category] })
    end

    # Then filter by search query
    if params[:query].present?
      search_term = "%#{params[:query].downcase}%"
      @products = @products.where(
        "LOWER(products.name) LIKE ? OR LOWER(products.ingredients) LIKE ?",
        search_term, search_term
      )
    end

    @products = @products.distinct
  end

  def show
    @product = Product.find_by(id: params[:id])
    unless @product
      redirect_to products_path, alert: "Product not found."
    end
  end
end
