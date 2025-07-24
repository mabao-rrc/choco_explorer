# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  def index
    @products = Product.includes(:brand, :categories, :countries)

    if params[:query].present?
      search_term = "%#{params[:query].downcase}%"
      @products = @products
        .left_outer_joins(:brand, :categories, :countries)
        .where(
          "LOWER(products.name) LIKE :q OR LOWER(products.ingredients) LIKE :q OR LOWER(products.nutrition_info) LIKE :q OR LOWER(brands.name) LIKE :q OR LOWER(categories.name) LIKE :q OR LOWER(countries.name) LIKE :q",
          q: search_term
        )
    end

    @products = @products.distinct.page(params[:page]).per(6)
  end

  def show
    @product = Product.find_by(id: params[:id])
    unless @product
      redirect_to products_path, alert: "Product not found."
    end
  end
end

